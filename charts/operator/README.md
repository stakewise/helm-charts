# README

> :warning: **Please note**: We take StakeWise's security and our users' trust very seriously. If 
you believe you have found a security issue in StakeWise Helm charts, _please responsibly disclose_ 
by contacting us at [security@stakewise.io](mailto:security@stakewise.io).

This repository contains the official StakeWise Helm charts for installing
and configuring large scale ETH staking infrastructure on top of the Kubernetes

> :book: **Check out the full documentation on the** [doc.stakewise.io](https://docs.stakewise.io/node-operator/infrastructure)

## Prerequisites

To use the charts here, [Helm](https://helm.sh/) must be configured for your
Kubernetes cluster. Setting up Kubernetes and Helm is outside the scope of
this README. Please refer to the Kubernetes and Helm documentation.

  * At least three nodes in the Kubernetes cluster with 8 CPU/16 GB RAM configuration.
1000 GB of Persistent Storage per node (SSD).
  * Helm 3.0+ - This is the earliest version of Helm tested. Charts may work with earlier versions but it is untested.
  * Kubernetes 1.18+ - This is the earliest version of Kubernetes tested. Charts may work with earlier versions but it is untested.
  * PV provisioner support in the underlying infrastructure

## Usage

To install the latest version of this chart, add dependent helm repositories
and run `helm install`:

```console
$ helm repo add hashicorp https://helm.releases.hashicorp.com
"hashicorp" has been added to your repositories
$ helm repo add stakewise https://charts.stakewise.io

$ helm repo update

$ helm upgrade --install operator stakewise/operator \
  --namespace operator \
  --set geth.enabled=true \
  --set key=value... 
```

**Please see the options supported in the `values.yaml` file.** And the full documentation at https://docs.stakewise.io

## Changelog

Please refer to the `CHANGELOG.md` file.
