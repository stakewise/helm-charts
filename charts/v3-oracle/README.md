# Oracle Helm Chart

Kubernetes Helm chart for deploying [v3-oracle](https://github.com/stakewise/v3-oracle).

## Introduction

Can be used to deploy StakeWise oracles on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.24+
- Helm 3

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm repo add stakewise https://charts.stakewise.io
helm upgrade --install v3-oracle stakewise/v3-oracle \
  --set settings.network="goerli" \
  --set settings.executionGraphqlEndpoint="http://localhost:6001/graphql" \
  --set settings.executionEndpoint="http://localhost:8545" \
  --set settings.consensusEndpoint="http://localhost:6002" \
  --set settings.ipfsLocalClientEndpoint="/dns/ipfs.example.com/tcp/443/https" \
  --set settings.walletPrivateKey="0x0000000000000000000000000000000000000000" \
  --set settings.ipfsInfuraClientUsername="username" \
  --set settings.ipfsInfuraClientPassword="password" \
  --set settings.ipfsWeb3StorageToken="token" \
  --namespace v3-oracle
```

The command deploys oracle on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists various ways to override default configuration during deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `v3-oracle` deployment:

```bash
helm delete v3-oracle
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

See `values.yaml` for configuration notes. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
helm install my-release stakewise/v3-oracle --set settings.executionEndpoints="XXXXXXXX" --set settings.consensusEndpoints="XXXXXXXX"
```

The above command specifies the web3 endpoint.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm upgrade --install v3-oracle stakewise/v3-oracle -f values.yaml
```

> **Tip**: You can override the default [values.yaml](values.yaml)
