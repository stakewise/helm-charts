# README

> :warning: **Please note**: We take StakeWise's security and our users' trust very seriously. If 
you believe you have found a security issue in StakeWise Helm charts, _please responsibly disclose_ 
by contacting us at [security@stakewise.io](mailto:security@stakewise.io).

This repository contains the official StakeWise Helm charts for installing
and configuring large scale ETH staking infrastructure on top of the Kubernetes

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

## How it works

![StakeWise Eth Operator](https://github.com/stakewise/helm-charts/raw/operator-package/eth-operator/img/scheme.png)

**Explanation of the schema**

`operator` chart is capable of deploying different ETH1 and ETH2 clients and allows seamless migration of the validators from one client to another while preserving the slashing database. By default, the chart deploys three instances of Prysm ETH2 nodes and one instance of Lighthouse ETH2 node which will serve as hot standby so that Prysm validators can migrate to Lighthouse without waiting for the ETH2 node to sync the chain. 

As the ETH2 node requires connection to the ETH1 node, the chart deploys by default two instances of the Geth clients and one instance of the OpenEthereum client that will also serve as a hot standby in case of the Geth client failure.

It's also possible to choose the ETH1 client. Currently, Geth (default) and OpenEthereum are supported. 

The validator's POD contains several init containers that take care of the slashing database migration to the right format and ensuring the keys can be read by the validator client.

The validator keys are stored in the HashiCorp Vault and every validator client can only fetch the keys that are supposed to be hosted by it.

## Usage

To install the latest version of this chart, add dependent helm repositories
and run `helm install`:

```console
$ helm repo add hashicorp https://helm.releases.hashicorp.com
"hashicorp" has been added to your repositories

$ helm dependency update

$ helm upgrade --install operator ./operator \
  --namepsace operator \
  --set geth.enabled=true \
  --set key=value... 
```

**Please see the options supported in the `values.yaml` file. And the prater testnet example configuration in the `values.example.yaml`**

## How to

1. Install helm chart with eth1 nodes `geth` and `openethereum` enabled. Wait until eth1 nodes fully synced.
1. Upgrade installation with eth2 nodes `prysm` and `lighthouse` enabled. Wait until eth2 nodes fully synced.
1. Upgrade installation with vault enabled and configured (instruction below).
1. Upgrade installation with validators enabled;

## Vault usage

After the Vault is installed one of the Vault servers need to be initialized. The initialization generates the credentials (keep it safe) necessary to unseal all the Vault servers.

Initialize and unseal `operator-vault-0` pod:

```console
$ kubectl exec -ti operator-vault-0 -- vault operator init
$ kubectl exec -ti operator-vault-0 -- vault operator unseal
```

Join the remaining pods to the Raft cluster and unseal them. The pods will need to communicate directly so we'll configure the pods to use the internal service provided by the Helm chart:

```console
$ kubectl exec -ti operator-vault-1 -- vault operator raft join http://operator-vault-0.operator-vault-internal:8200
$ kubectl exec -ti operator-vault-1 -- vault operator unseal

$ kubectl exec -ti operator-vault-2 -- vault operator raft join http://operator-vault-0.operator-vault-internal:8200
$ kubectl exec -ti operator-vault-2 -- vault operator unseal
```

To verify if the Raft cluster has successfully been initialized, run the following.

First, login using the root token on the `operator-vault-0` pod:

```console
$ kubectl exec -ti operator-vault-0 -- vault login
```

Next, list all the raft peers:

```console
$ kubectl exec -ti operator-vault-0 -- vault operator raft list-peers

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
  --namespace operator
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

First, start an interactive shell session on the `operator-vault-0` pod.

```console
$ kubectl exec -ti operator-vault-0 -- sh
export VAULT_TOKEN=token
```

Enable the Kubernetes authentication method.

```console
$ vault auth enable kubernetes
Success! Enabled kubernetes auth method at: kubernetes/
```

Configure the Kubernetes authentication method to use the service account token, the location of the Kubernetes host, and its certificate. Replace `{{ KUBERNETES_PORT_443_TCP_ADDR }}` with Kubernetes cluster API endpoint.

```console
$ vault write auth/kubernetes/config \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://{{ KUBERNETES_PORT_443_TCP_ADDR }}:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

Success! Data written to: auth/kubernetes/config
```

The `token_reviewer_jwt` and `kubernetes_ca_cert` files written to the container by Kubernetes. The variable `{{ KUBERNETES_PORT_443_TCP_ADDR }}` references the internal network address of the Kubernetes host and should be manually updated in the command above.

Lastly, exit the `operator-vault-0` pod.

```console
$ exit
```

## High Availability and Security Recommendations

To ensure high availability and security of the operator's node infrastructure, we recommend the following things:

1. Deploy at least 3 replicas of eth1 and eth2 nodes. Always use persistent storage for your eth1/eth2 nodes as re-syncing takes too long.
1. Use a vault cluster of at least 3 nodes to ensure that keystors are available in the event of a validator restart. We also recommend setting up auto-unseal.
1. **NEVER** share your vault token with anyone else, keep it as safe as possible.
1. **NEVER** run 2 replicas of validators with the same keystores as you risk to be slashed.
1. Always keep Kubernetes API in a private network and do not expose it outside.
1. If possible, use a separate Kuberenetes cluster for the infrastructure of the operator's nodes.
1. If possible, do not keep more than 1000 keystores in one Kubernetes cluster, use different regions / accounts for every 1000 keystore, thus improving security, resiliency and decentralization.
1. Limit access to the Kubernetes cluster as much as possible for everyone except those who really need it.
1. Do not use spot instances, because with frequent restarts of validators there is a risk of missing attestations.

## Documentation

- https://geth.ethereum.org/docs/
- https://openethereum.github.io/
- https://docs.prylabs.network/docs/getting-started/
- https://lighthouse-book.sigmaprime.io/
- https://www.coincashew.com/coins/overview-eth/guide-or-how-to-setup-a-validator-on-eth2-mainnet
- https://learn.hashicorp.com/tutorials/vault/kubernetes-google-cloud-gke?in=vault/kubernetes
