# StakeWise Helm Charts for Kubernetes

This repository contains a curated list of StakeWise Helm charts, with each chart located in a separate folder and its configuration parameters defined in the `values.yaml` file.

## Quick Start

To install a chart from this repository, add the StakeWise repository to your local Helm client:

```bash
helm repo add stakewise https://charts.stakewise.io
```

You can then deploy a chart by running:

```bash
helm install my-release stakewise/<chart-name>
```

Make sure to replace `<chart-name>` with the name of the chart you want to install.

## Prerequisites

Before you can use these Helm charts, you will need:

* Kubernetes 1.20+
* Helm 3
* PV provisioner support in the underlying infrastructure (for some charts)

If you are new to Kubernetes or Helm, we recommend following the guides below to get started:

* [Kubernetes Getting Started Guide](https://kubernetes.io/docs/getting-started/)
* [Helm Installation Guide](https://helm.sh/docs/intro/install/)

## Using Helm
O
nce you have installed the Helm client and added the StakeWise repository, you can use Helm to manage packages on your Kubernetes cluster. For more information on how to use Helm, refer to the [official documentation](https://helm.sh/docs/intro/using_helm/).

Here are some useful Helm commands to get started:

* Install a chart: `helm install my-release stakewise/<chart-name>`
* Upgrade your application: `helm upgrade`
