# Teku Validator Setup

This guide will walk you through creating a new Teku Validator, loading an existing keystore to it, and creating a Kubernetes secret to store your keystore securely.

Teku is an open-source Ethereum 2.0 validator client developed by ConsenSys. It is written in Java and designed to be highly secure, performant, and easy to use. Teku is one of several Ethereum 2.0 clients that validators can use to participate in the network and earn rewards for validating blocks.

Teku offers a number of features that make it an attractive choice for validators, including support for multiple operating systems and hardware architectures, a modular architecture that allows for easy customization and extension, and built-in support for slashing protection and other security features.

In addition, Teku includes a user-friendly command-line interface and extensive documentation to help validators get started quickly and easily. It also includes a number of tools and utilities for managing and monitoring validators, such as a validator performance dashboard and a metrics exporter for use with Prometheus.

Overall, Teku is a powerful and reliable validator client that is well-suited for both individual and institutional validators looking to participate in Ethereum 2.0 and earn rewards for securing the network.

## Prerequisites

* Teku Validator installed on your local machine or a remote server.
* Kubernetes CLI (kubectl) installed and configured to access your cluster.
* Access to a running Kubernetes cluster.

## Creating secrets with keystores and password

> When setting up a Teku Validator and creating a Kubernetes secret to store your keystores and passwords, it's important to name the secret files consistently. This is because the Teku Validator expects a specific naming pattern in order to find and use your keystore.
>
> The naming pattern for the Kubernetes secret should be `keystore-{index}`, index represents kubernetes replica, if `replicasCount=2` you must create two secrets `keystore-0` and `keystore-1`. This ensures that the Teku Validator can find the correct secret when it looks for your keystore.
>
> By following these naming conventions, you can ensure that your Teku Validator is set up correctly and ready to use.

1. Create secrets with keystores and passswords. This will create a new secrets with keystore files and a password. If you have more then 100 keystores it's better to split it in multiple replicas, for this create multiple secrets with 100 keystores in each and load it to Kubernetes as secrets. You can do this with the following command:

```javascript
kubectl create secret generic keystore-0 --from-file=/path/to/my-wallet/keystores-0 --from-file=/path/to/my-wallet/passwords-0
kubectl create secret generic keystore-1 --from-file=/path/to/my-wallet/keystores-1 --from-file=/path/to/my-wallet/passwords-1
```

> `/path/to/my-wallet/keystores-0` expects keystores with the name `keystore*.json`. Additionally, plain text files with the password for each keystore should be located in `/path/to/my-wallet/keystores-0` and follow the naming convention `keystore*.txt`. This means that each `keystore*.json` file should have a corresponding file with the same name but a `.txt` extension containing its password.

This will create a new Kubernetes secrets named `keystore-0` and `keystore-1` that contains your keystore files and passwords.

## Deploy Teku Validator

```bash
helm repo add stakewise https://charts.stakewise.io
helm repo update
helm upgrade --install teku-validator stakewise/teku-validator \
  --namespace validators \
  --create-namespace \
  --set global.network="goerli" \
  --set replicaCount=2
```
