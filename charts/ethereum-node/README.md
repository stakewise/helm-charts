# ethereum-node

![Version: 0.0.20](https://img.shields.io/badge/Version-0.0.20-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

This chart acts as an umbrella chart and allows to run a ethereum execution and consensus layer client. It's also able to deploy optional monitoring applications.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Manjeet-Nethermind | <manjeet@nethermind.io> |  |
| gehlotanish | <anish@nethermind.io> |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ethpandaops.github.io/ethereum-helm-charts | nethermind | 1.0.9 |
| https://ethpandaops.github.io/ethereum-helm-charts | prysm | 1.1.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ethereum-metrics-exporter.config.consensus.enabled | bool | `true` |  |
| ethereum-metrics-exporter.config.consensus.name | string | `"consensus-client"` |  |
| ethereum-metrics-exporter.config.consensus.url | string | `"{{ tpl  .Values.global.main.beaconEndpoint . }}"` |  |
| ethereum-metrics-exporter.config.execution.enabled | bool | `true` |  |
| ethereum-metrics-exporter.config.execution.modules[0] | string | `"eth"` |  |
| ethereum-metrics-exporter.config.execution.modules[1] | string | `"net"` |  |
| ethereum-metrics-exporter.config.execution.modules[2] | string | `"web3"` |  |
| ethereum-metrics-exporter.config.execution.name | string | `"execution-client"` |  |
| ethereum-metrics-exporter.config.execution.url | string | `"{{ tpl  .Values.global.main.rpcEndpoint . }}"` |  |
| ethereum-metrics-exporter.enabled | bool | `false` |  |
| ethereum-metrics-exporter.nameOverride | string | `"metrics-exporter"` |  |
| global.checkpointSync.addresses.goerli | string | `"https://checkpoint-sync.goerli.ethpandaops.io"` |  |
| global.checkpointSync.addresses.mainnet | string | `"https://mainnet-checkpoint-sync.attestant.io"` |  |
| global.checkpointSync.addresses.sepolia | string | `"https://checkpoint-sync.sepolia.ethpandaops.io"` |  |
| global.checkpointSync.enabled | bool | `true` |  |
| global.clientArgs.networks.goerli.consensus.prysm[0] | string | `"--goerli"` |  |
| global.clientArgs.networks.goerli.execution.nethermind[0] | string | `"--config=goerli"` |  |
| global.clientArgs.networks.mainnet.consensus.prysm | list | `[]` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[0] | string | `"--Pruning.Mode=Hybrid"` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[1] | string | `"--Pruning.FullPruningTrigger=VolumeFreeSpace"` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[2] | string | `"--Pruning.FullPruningThresholdMb=256000"` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[3] | string | `"--Pruning.AvailableSpaceCheckEnabled=false"` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[4] | string | `"--Sync.NonValidatorNode=true"` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[5] | string | `"--Sync.DownloadBodiesInFastSync=false"` |  |
| global.clientArgs.networks.mainnet.execution.nethermind[6] | string | `"--Sync.DownloadReceiptsInFastSync=false"` |  |
| global.clientArgs.networks.sepolia.consensus.prysm[0] | string | `"--sepolia"` |  |
| global.clientArgs.networks.sepolia.execution.nethermind[0] | string | `"--config=sepolia"` |  |
| global.main.beaconEndpoint | string | `"http://{{ .Release.Name }}-beacon:5052"` |  |
| global.main.engineEndpoint | string | `"http://{{ .Release.Name }}-execution:8551"` |  |
| global.main.env | string | `"staging"` |  |
| global.main.network | string | `"mainnet"` |  |
| global.main.rpcEndpoint | string | `"http://{{ .Release.Name }}-execution:8545"` |  |
| global.secretStore.gcp.clusterLocation | string | `"dummy-cluster-location"` |  |
| global.secretStore.gcp.clusterName | string | `"dummy-cluster-name"` |  |
| global.secretStore.gcp.projectID | string | `"dummy-project-id"` |  |
| global.secretStore.gcp.serviceAccountRef.name | string | `"dummy-service-account"` |  |
| global.secretStore.gcp.serviceAccountRef.namespace | string | `"dummy-namespace"` |  |
| global.secretStore.refreshInterval | string | `"10m"` |  |
| global.secretStore.remoteRef.key | string | `"dummy-key"` |  |
| global.secretStore.remoteRef.property | string | `"dummy-property"` |  |
| global.secretStore.remoteRef.version | string | `"1"` |  |
| nethermind.enabled | bool | `true` |  |
| nethermind.extraArgs[0] | string | `"{{- with( index .Values.global.clientArgs.networks .Values.global.main.network ) }}\n  {{- range $i, $v := .execution.nethermind }}\n  {{- if (eq $i 0) }}\n  {{- $v }}\n  {{- else }}\n  {{ $v }}\n  {{- end }}\n  {{- end -}}\n{{- end }}"` |  |
| nethermind.httpPort | int | `8545` |  |
| nethermind.nameOverride | string | `"execution"` |  |
| nethermind.p2pPort | int | `30303` |  |
| prysm.checkpointSync.enabled | string | `"{{ default .Values.global.checkpointSync.enabled false }}"` |  |
| prysm.checkpointSync.url | string | `"{{ index .Values.global.checkpointSync.addresses .Values.global.main.network }}"` |  |
| prysm.enabled | bool | `true` |  |
| prysm.extraArgs[0] | string | `"--execution-endpoint={{ tpl .Values.global.main.engineEndpoint . }} {{- with( index .Values.global.clientArgs.networks .Values.global.main.network ) }}\n  {{- range .consensus.prysm }}\n  {{ . }}\n  {{- end -}}\n{{- end -}}"` |  |
| prysm.httpPort | int | `5052` |  |
| prysm.nameOverride | string | `"beacon"` |  |
| prysm.p2pPort | int | `9000` |  |
| prysm.persistence.accessModes | list | `["ReadWriteOnce"]` | Use an existing PVC when persistence.enabled |
| prysm.persistence.annotations | object | `{}` | Annotations for volume claim template |
| prysm.persistence.enabled | bool | `true` | Uses an EmptyDir when not enabled |
| prysm.persistence.selector | object | `{}` | Selector for volume claim template |
| prysm.persistence.size | string | `"100Gi"` | Requested size for volume claim template |
| prysm.persistence.storageClassName | string | `"standard-rwo"` | Use a specific storage class E.g 'local-path' for local storage to achieve best performance Read more (https://github.com/rancher/local-path-provisioner) |
| prysm.resources.limits.cpu | int | `4` |  |
| prysm.resources.limits.memory | string | `"4Gi"` |  |
| prysm.resources.requests.cpu | int | `2` |  |
| prysm.resources.requests.memory | string | `"2Gi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
