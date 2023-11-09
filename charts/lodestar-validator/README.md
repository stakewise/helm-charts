# Lodestar Validator Setup

This guide will walk you through creating a new Lodestar Validator, loading an existing keystore to it, and creating a Kubernetes secret to store your keystore securely.

Lodestar is an open-source Ethereum 2.0 validator client developed by Sigma Prime. It is written in Rust and designed to be highly secure, efficient, and flexible. Lodestar is one of several Ethereum 2.0 clients that validators can use to participate in the network and earn rewards for validating blocks.

Lodestar offers a number of features that make it an attractive choice for validators, including a highly optimized beacon node that can handle a large number of validators, support for multiple operating systems and hardware architectures, and robust support for handling slashing events and other security threats.

In addition, Lodestar is designed to be modular and flexible, making it easy to customize and extend as needed. It also includes a user-friendly command-line interface and extensive documentation to help validators get started quickly and easily.

Overall, Lodestar is a powerful and reliable validator client that is well-suited for both individual and institutional validators looking to participate in Ethereum 2.0 and earn rewards for securing the network.

## Prerequisites

* Lodestar Validator installed on your local machine or a remote server.
* Kubernetes CLI (kubectl) installed and configured to access your cluster.
* Access to a running Kubernetes cluster.

## Creating secrets with keystores and password

> When setting up a Lodestar Validator and creating a Kubernetes secret to store your keystores and passwords, it's important to name the secret files consistently. This is because the Lodestar Validator expects a specific naming pattern in order to find and use your keystore.
>
> The naming pattern for the Kubernetes secret should be `keystore-{index}`, index represents kubernetes replica, if `replicasCount=2` you must create two secrets `keystore-0` and `keystore-1`. This ensures that the Lodestar Validator can find the correct secret when it looks for your keystore.
>
> By following these naming conventions, you can ensure that your Lodestar Validator is set up correctly and ready to use.

1. Create secrets with keystores and passswords. This will create a new secrets with keystore files and a password. If you have more then 100 keystores it's better to split it in multiple replicas, for this create multiple secrets with 100 keystores in each and load it to Kubernetes as secrets. You can do this with the following command:

```javascript
kubectl create secret generic keystore-0 --from-file=/path/to/my-wallet/keystores-0 --from-file=/path/to/my-wallet/keystore-0.txt
kubectl create secret generic keystore-1 --from-file=/path/to/my-wallet/keystores-1 --from-file=/path/to/my-wallet/keystore-1.txt
```

> `/path/to/my-wallet/keystores-0` expect keystores with name `keystore*.json` and `/path/to/my-wallet/keystore-0.txt` plain txt with password for these keystores.

This will create a new Kubernetes secrets named `keystore-0` and `keystore-1` that contains your keystore files and passwords.

## Deploy Lodestar Validator

```bash
helm repo add stakewise https://charts.stakewise.io
helm repo update
helm upgrade --install lodestar-validator stakewise/lodestar-validator \
  --namespace validators \
  --create-namespace \
  --set global.network="goerli" \
  --set replicaCount=2
```
