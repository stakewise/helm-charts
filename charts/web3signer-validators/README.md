# README

> :book: **Check out the full documentation on the** [docs-v3.stakewise.io](https://docs-v3.stakewise.io/for-operators/kuberentes)

## Usage

To install the latest version of this chart, add dependent helm repositories
and run `helm install`:

```console
$ helm repo add stakewise https://charts.stakewise.io

$ helm repo update

$ helm upgrade --install validators stakewise/web3signer-validators \
  --set='network=mainnet' \
  --set='type=lighthouse' \
  --set='validatorsCount=8' \
  --set='beaconChainRpcEndpoints[0]=http://lighthouse-0.chain:5052' \
  --set='beaconChainRpcEndpoints[1]=http://lighthouse-1.chain:5052' \
  --set='beaconChainRpcEndpoints[2]=http://lighthouse-2.chain:5052' \
  --set='web3signerEndpoint=http://web3signer:6174' \
  --set='dbKeystoreUrl=postgresql://example:example@cloudsqlproxy.default/web3signer_keys' \
  --set='graffiti=StakeWise' \
  --set='metrics.enabled=true' \
  --set='metrics.serviceMonitor.enabled=true' \
  --set='metrics.prometheusRule.enabled=true' \
  --set='suggestedFeeRecipient={FEE_RECIPIENT_ADDRESS}' \
  --create-namespace \
  --namespace validators
```

> `validatorsCount`: This determines the total number of validators you're going to use. The validator keys will be distributed equally among all validators. For example, if you have 1000 keys and 10 validators, each validator will have 100 keys. If you have 20 validators, each will have 50 keys and so on.
> `{FEE_RECIPIENT_ADDRESS}` - address from the vault page in the details section: Validator fee recipient

**Please see the options supported in the `values.yaml` file.** The full documentation is available at https://docs.stakewise.io/node-operator/stakewise-infra-package/usage

## Changelog

Please refer to the `CHANGELOG.md` file.
