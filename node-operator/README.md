# README

> :warning: **Please note**: We take StakeWise's security and our users' trust very seriously. If 
you believe you have found a security issue in StakeWise Helm charts, _please responsibly disclose_ 
by contacting us at [security@stakewise.io](mailto:security@stakewise.io).

This repository contains the official StakeWise Helm charts for installing
and configuring Node Operator infrastructure on Kubernetes.

## Prerequisites

To use the charts here, [Helm](https://helm.sh/) must be configured for your
Kubernetes cluster. Setting up Kubernetes and Helm is outside the scope of
this README. Please refer to the Kubernetes and Helm documentation.

The versions required are:

  * **Helm 3.0+** - This is the earliest version of Helm tested. It is possible
    it works with earlier versions but this chart is untested for those versions.
  * **Kubernetes 1.18+** - This is the earliest version of Kubernetes tested.
    It is possible that this chart works with earlier versions but it is
    untested.

## Usage

To install the latest version of this chart, add dependent helm repositories
and run `helm install`:

```console
$ helm repo add hashicorp https://helm.releases.hashicorp.com
"hashicorp" has been added to your repositories

$ helm dependency update

$ helm upgrade --install node-operator ./operator/node-operator \
  --namepsace node-operator \
  --set geth.enabled=true \
  --set key=value... 
```

Please see the many options supported in the `values.yaml` file.

### Vault usage

After the Vault is installed one of the Vault servers need to be initialized. The initialization generates the credentials (keep it safe) necessary to unseal all the Vault servers.

Initialize and unseal `node-operator-vault-0` pod:

```console
$ kubectl exec -ti node-operator-vault-0 -- vault operator init
$ kubectl exec -ti node-operator-vault-0 -- vault operator unseal
```

Join the remaining pods to the Raft cluster and unseal them. The pods will need to communicate directly so we'll configure the pods to use the internal service provided by the Helm chart:

```console
$ kubectl exec -ti node-operator-vault-1 -- vault operator raft join http://node-operator-vault-0.node-operator-vault-internal:8200
$ kubectl exec -ti node-operator-vault-1 -- vault operator unseal

$ kubectl exec -ti node-operator-vault-2 -- vault operator raft join http://node-operator-vault-0.node-operator-vault-internal:8200
$ kubectl exec -ti node-operator-vault-2 -- vault operator unseal
```

To verify if the Raft cluster has successfully been initialized, run the following.

First, login using the root token on the `node-operator-vault-0` pod:

```console
$ kubectl exec -ti node-operator-vault-0 -- vault login
```

Next, list all the raft peers:

```console
$ kubectl exec -ti node-operator-vault-0 -- vault operator raft list-peers

Node                                    Address                        State       Voter
----                                    -------                        -----       -----
a1799962-8711-7f28-23f0-cea05c8a527d    vault-0.vault-internal:8201    leader      true
e6876c97-aaaa-a92e-b99a-0aafab105745    vault-1.vault-internal:8201    follower    true
4b5d7383-ff31-44df-e008-6a606828823b    vault-2.vault-internal:8201    follower    true
```

Vault with integrated storage (Raft) is now ready to use!

### Vault Auto Unseal

1. Create Google Service Account and Download JSON

```console
$ gcloud iam service-accounts create SERVICE_ACCOUNT_ID \
    --description="DESCRIPTION" \
    --display-name="DISPLAY_NAME"
$ gcloud iam service-accounts keys create key-file \
    --iam-account=sa-name@project-id.iam.gserviceaccount.com
```

2. Create Kubernetes secret with GCP credentials generated above

```console
$ kubectl create secret generic gcp-creds \
  --from-file=gcp-creds.json=./google-project-ID.json \
  --namespace node-operator
```

3. Create keyring

```console
$ gcloud kms keyrings create key-ring \
    --location location
$ gcloud kms keys add-iam-policy-binding key \
    --keyring key-ring \
    --location location \
    --member principal-type:principal-email \
    --role roles/cloudkms.cryptoKeyEncrypterDecrypter
```

4. Update `values.yaml`

```yaml
vault:
    ....
    ha:
      ...
      raft:
        enabled: true
        config: |
          ui = true
          listener "tcp" {
            tls_disable = 1
            address = "[::]:8200"
            cluster_address = "[::]:8201"
          }
          storage "raft" {
            path = "/vault/data"
          }
          service_registration "kubernetes" {}
          seal "gcpckms" {
             project     = "PROJECT_ID"
             region      = "global"
             key_ring    = "KEY_RING"
             crypto_key  = "vault"
          }
    extraEnvironmentVars:
      GOOGLE_REGION: global
      GOOGLE_PROJECT: PROJECT_ID
      GOOGLE_APPLICATION_CREDENTIALS: /vault/userconfig/PROJECT_ID/gcp-creds.json
    volumes:
      - name: gcp-creds
        secret:
          secretName: gcp-creds
          items:
            - key: gcp-creds.json
              path: gcp-creds.json
    volumeMounts:
      - name: gcp-creds
        mountPath: "/vault/userconfig/stakewise/gcp-creds.json"
        subPath: gcp-creds.json
        readOnly: true
```

5. Deploy chart with updated `values.yaml`

### Configure Vault + Kubernetes authentication

Vault provides a Kubernetes authentication method that enables clients to authenticate with a Kubernetes Service Account Token. The Kubernetes resources that access the secret and create the volume authenticate through this method through a role.

First, start an interactive shell session on the `node-operator-vault-0` pod.

```console
$ kubectl exec -ti node-operator-vault-0 -- sh
export VAULT_TOKEN=token
```

Enable the Kubernetes authentication method.

```console
$ vault auth enable kubernetes
Success! Enabled kubernetes auth method at: kubernetes/
```

Configure the Kubernetes authentication method to use the service account token, the location of the Kubernetes host, and its certificate. Replace `{{ KUBERNETES_PORT_443_TCP_ADDR }}` with Kubernetes cluster API endpoint.

> **Google Cloud Platform issuer example:**
> 
> `issuer="https://container.googleapis.com/v1/projects/PROJECT_ID/locations/REGION_NAME/clusters/CLUSTER_NAME"`

```console
$ vault write auth/kubernetes/config \
  issuer="https://kubernetes.default.svc.cluster.local" \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://{{ KUBERNETES_PORT_443_TCP_ADDR }}:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

Success! Data written to: auth/kubernetes/config
```

The `token_reviewer_jwt` and `kubernetes_ca_cert` files written to the container by Kubernetes. The variable `{{ KUBERNETES_PORT_443_TCP_ADDR }}` references the internal network address of the Kubernetes host and should be manually updated in the command above.

For the Kubernetes-Secrets-Store-CSI-Driver to read the secrets requires that it has read permissions of all mounts and access to the secret itself.

Write out the policy named `internal-app`.

```console
$ vault policy write internal-app - <<EOF
path "validators/*" {
  capabilities = ["read"]
}
EOF
```

The data of `kv-v2` requires that an additional path element of data is included after its mount path (in this case, validators/data).

Finally, create a Kubernetes authentication role named node-operator that binds this policy with a Kubernetes service account named `node-operator`.

```console
$ vault write auth/kubernetes/role/node-operator \
    bound_service_account_names=node-operator \
    bound_service_account_namespaces=${VAULT_K8S_NAMESPACE} \
    policies=internal-app \
    ttl=20m

Success! Data written to: auth/kubernetes/role/node-operator
```

The role connects the Kubernetes service account, `node-operator`, in the namespace, `node-operator`, with the Vault policy, `internal-app`. The tokens returned after authentication are valid for 20 minutes. This Kubernetes service account name, `node-operator`, will be created below.

Lastly, exit the `node-operator-vault-0` pod.

```console
$ exit
```

## Documentation

- https://geth.ethereum.org/docs/
- https://openethereum.github.io/
- https://docs.prylabs.network/docs/getting-started/
- https://lighthouse-book.sigmaprime.io/
- https://www.coincashew.com/coins/overview-eth/guide-or-how-to-setup-a-validator-on-eth2-mainnet
- https://learn.hashicorp.com/tutorials/vault/kubernetes-google-cloud-gke?in=vault/kubernetes
- https://learn.hashicorp.com/tutorials/vault/kubernetes-secret-store-driver?in=vault/kubernetes