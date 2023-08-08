# Operator Helm Chart

This Helm chart allows you to deploy the StakeWise v3-operator into a Kubernetes cluster. The v3-operator plays a vital role in the StakeWise ecosystem, and this Helm chart aims to simplify its deployment.

## Introduction

The StakeWise v3-operator can be deployed on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager. This document provides step-by-step instructions for installation, configuration, and management of the Helm chart.

## Prerequisites

Before you start, make sure your environment meets the following prerequisites:

- Kubernetes 1.20 or higher
- Helm 3
- Operator data created as Kubernetes secrets

## Create Kubernetes secrets with operator data

Kubernetes secrets are used to store sensitive information related to the v3-operator. Use the following commands to create the necessary secrets:

```bash
kubectl create secret generic v3-operator-deposit-data --from-file=/home/username/.stakewise/0xeefffd4c23d2e8c845870e273861e7d60df49663/deposit_data.json
kubectl create secret generic v3-operator-keystores-data --from-file=/home/username/.stakewise/0xeefffd4c23d2e8c845870e273861e7d60df49663/keystores
kubectl create secret generic v3-operator-wallet-data --from-file=/home/username/.stakewise/0xeefffd4c23d2e8c845870e273861e7d60df49663/wallet
```

> Replace `0xeefffd4c23d2e8c845870e273861e7d60df49663` with the actual vault contract address

## Installing the Chart

To install the chart with the release name `v3-operator`, execute the following commands:

```bash
helm repo add stakewise https://charts.stakewise.io
helm install v3-operator  stakewise/v3-operator \
  --set settings.network="goerli" \
  --set settings.vault="0xeefffd4c23d2e8c845870e273861e7d60df49663" \
  --set settings.executionEndpoints="https://node.example.com/execution" \
  --set settings.consensusEndpoints="https://node.example.com/consensus" \
  --set settings.depositDataSecretName: "v3-operator-deposit-data" \
  --set settings.keystoresSecretName: " v3-operator-keystores-data" \
  --set settings.walletSecretName: "v3-operator-wallet-data"
```

This command deploys the v3-operator with default configuration. Refer to the configuration section to learn more about customizing your deployment.

Alternatively, use a YAML file with specific values:

```bash
$ helm install v3-operator stakewise/v3-operator -f values.yaml
```

> **Tip**: You can override the default [values.yaml](values.yaml)

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `v3-operator` deployment, use:

```bash
$ helm delete v3-operator
```

This command removes all Kubernetes components associated with the chart and deletes the release.

