# Prysm Validator Setup

This guide will walk you through creating a new Prysm Validator, loading an existing keystore to it, and creating a Kubernetes secret to store your keystore securely.

Prysm is a client implementation for the Ethereum 2.0 blockchain. More specifically, it is a validator client that allows users to participate in the Ethereum 2.0 network by running a validator node. Validators play a critical role in the Ethereum 2.0 network by validating transactions and blocks and helping to secure the network.

Prysm is designed to be easy to use and highly scalable, making it a popular choice for Ethereum 2.0 validators. It is built using the Go programming language and provides a number of features that make it well-suited for running a validator node, such as support for multiple validators, automatic slashing protection, and a web-based user interface.

If you're interested in running a validator node on the Ethereum 2.0 network, Prysm is a solid choice that offers a great balance of ease-of-use and advanced features.

## Prerequisites

* Prysm Validator installed on your local machine or a remote server.
* Kubernetes CLI (kubectl) installed and configured to access your cluster.
* Access to a running Kubernetes cluster.

## Creating a new wallet

> When setting up a Prysm Validator wallet and creating a Kubernetes secret to store your keystore, it's important to name the secret and wallet/password files consistently. This is because the Prysm Validator expects a specific naming pattern in order to find and use your keystore.
>
> The naming pattern for the Kubernetes secret should be `keystore-{index}`, index represents kubernetes replica, if `replicasCount=2` you must create two secrets `keystore-0` and `keystore-1`. This ensures that the Prysm Validator can find the correct secret when it looks for your keystore.
> 
> Similarly, the naming pattern for your wallet and password files should be `keystore-{index}.json` and `password-{index}.txt`, respectively. This is the naming pattern that the Prysm Validator expects, and using a different naming convention may cause the validator to fail to load your keystore.

By following these naming conventions, you can ensure that your Prysm Validator wallet is set up correctly and ready to use.

1. Create a new directory to store your wallet files.

```perl
mkdir my-wallet
```

2. Create a new keystore for your validator using the `prysm.sh validator accounts create` command. This will create a new keystore file and a password file. If you have more then 100 keystores it's better to split it in multiple replicas, for this create multiple wallets with 100 keystores in each and load it to Kubernetes as secrets. 

```css
prysm.sh validator wallet create --wallet-dir=/path/to/my-wallet/keystore-0 --keymanager-kind=imported --wallet-password-file=/path/to/my-wallet/keystore-0.txt
prysm.sh validator wallet create --wallet-dir=/path/to/my-wallet/keystore-1 --keymanager-kind=imported --wallet-password-file=/path/to/my-wallet/keystore-1.txt
```

3. Import your existing keystore to the new wallet using the `prysm.sh validator accounts import` command. You will need to provide the path to your keystore file and the corresponding password file.

```javascript
prysm.sh validator accounts import --wallet-dir=/path/to/my-wallet/keystore-0 --wallet-password-file=/path/to/my-wallet/keystore-0.txt --keys-dir=/path/to/keystores-0 --account-password-file=/path/to/keystore-0.txt
...
prysm.sh validator accounts import --wallet-dir=/path/to/my-wallet/keystore-1 --wallet-password-file=/path/to/my-wallet/keystore-1.txt --keys-dir=/path/to/keystores-1 --account-password-file=/path/to/keystore-1.txt
...
```

4. Create a Kubernetes secret to store your keystore securely. You can do this with the following command:

```javascript
kubectl create secret generic keystore-0 --from-file=/path/to/my-wallet/keystore-0.json --from-file=/path/to/my-wallet/keystore-0.txt
kubectl create secret generic keystore-1 --from-file=/path/to/my-wallet/keystore-1.json --from-file=/path/to/my-wallet/keystore-1.txt
```

This will create a new Kubernetes secrets named `keystore-0` and `keystore-1` that contains your keystore files and passwords.

## Deploy Prysm Validator

```bash
helm repo add stakewise https://charts.stakewise.io
helm repo update
helm upgrade --install prysm-validator stakewise/prysm-validator \
  --namespace validators \
  --create-namespace \
  --set global.network="goerli" \
  --set beaconRpcProvider="prysm.goerli-nodes:4000" \
  --set replicaCount=2
```
