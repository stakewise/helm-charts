# Horcrux Helm Chart

Kubernetes Helm chart for deploying StakeWise BLS Horcrux dispatcher.

## TL;DR;

```bash
$ helm repo add stakewise https://charts.stakewise.io
$ helm install my-release --set dispatcher.authenticationKey="abcd1234" stakewise/horcrux
```

## Introduction

Can be used to deploy StakeWise BLS Horcrux dispatcher on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.14+
- Helm 3

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add stakewise https://charts.stakewise.io
$ helm install my-release stakewise/horcrux
```

The command deploys Horcrux dispatcher on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists various ways to override default configuration during deployment.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

## Configuration

See `values.yaml` for configuration notes. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-release ./horcrux --set dispatcher.authenticationKey="abcd1234"
```

The above command specifies the authentication key for the dispatcher.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release stakewise/horcrux -f values.yaml
```

> **Tip**: You can override the default [values.yaml](values.yaml)