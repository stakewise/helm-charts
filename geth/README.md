# Geth Helm Chart

Kubernetes Helm chart for deploying Ethereum [Geth](https://github.com/ethereum/go-ethereum) nodes.

## TL;DR;

```bash
$ git clone git@github.com:stakewise/helm-charts.git
$ cd helm-charts
$ helm install my-release ./geth
```

## Introduction

Can be used to deploy private ETH1 chain or its components (bootnode, miner or node) on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.14+
- Helm 3
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ git clone git@github.com:stakewise/helm-charts.git
$ cd helm-charts
$ helm install my-release ./geth
```

The command deploys Geth on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists various ways to override default configuration during deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components but PVC's associated with the chart and deletes the release.

To delete the PVC's associated with `my-release`:

```bash
$ kubectl delete pvc -l release=my-release
```

## Configuration

See `values.yaml` for configuration notes. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-release ./geth --set bootnode.enabled=true
```

The above command enables the bootnode deployment.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release ./geth -f values.yaml
```

> **Tip**: You can override the default [values.yaml](values.yaml)