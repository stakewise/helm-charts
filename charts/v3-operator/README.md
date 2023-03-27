# Oracle Helm Chart

Kubernetes Helm chart for deploying oracle - the entity which is responsible for reading StakeWise pool validators data from beacon chain and submitting
it to the [Oracles](https://github.com/stakewise/contracts/blob/master/contracts/Oracles.sol) smart contract.

## Introduction

Can be used to deploy StakeWise oracles on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.14+
- Helm 3

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add stakewise https://charts.stakewise.io
$ kubectl create secret generic keystores --from-file=keystores/
$ helm install my-release --set settings.network="goerli" stakewise/v3-operator
```

The command deploys oracle on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists various ways to override default configuration during deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

See `values.yaml` for configuration notes. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-release stakewise/oracle --set settings.awsAccessKeyID="XXXXXXXX" --set settings.awsSecretAccessKey="XXXXXXXX"
```

The above command specifies the web3 endpoint.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release stakewise/oracle -f values.yaml
```

> **Tip**: You can override the default [values.yaml](values.yaml)