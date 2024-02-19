# web3signer

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.11.0](https://img.shields.io/badge/AppVersion-23.11.0-informational?style=flat-square)

A Helm chart for installing and configuring Web3signer

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| matilote |  |  |
| aivarasko |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../common | common | 1.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity  |
| cliImage | object | `{"pullPolicy":"IfNotPresent","repository":"nethermindeth/keystores-cli","tag":"v1.0.0"}` | CLI image is used to fetch private keys.  |
| enableReloader | bool | `false` |  |
| externalSecrets.data | list | `[]` |  |
| externalSecrets.enabled | bool | `true` |  |
| externalSecrets.secretStoreRef.kind | string | `"secretStoreKind"` |  |
| externalSecrets.secretStoreRef.name | string | `"secretStoreName"` |  |
| flywayImage | object | `{"pullPolicy":"IfNotPresent","repository":"flyway/flyway","tag":"9.3"}` | Flyawy image is used to apply database migrations  |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources  |
| global.label | string | `""` |  |
| global.podSecurityContext | object | `{"fsGroup":10000,"runAsNonRoot":true,"runAsUser":10000}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| global.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| global.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| global.securityContext.runAsNonRoot | bool | `true` |  |
| global.securityContext.runAsUser | int | `10000` |  |
| global.serviceAccount.create | bool | `true` |  |
| httpPort | int | `6174` | Port on which Web3Signer HTTP listens.  |
| idleTimeout | int | `30` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"consensys/web3signer"` |  |
| image.tag | string | `"23.11.0"` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| initImage | object | `{"pullPolicy":"IfNotPresent","repository":"busybox","tag":"1.36"}` | Init image is used to chown data volume, etc.  |
| loggingLevel | string | `"INFO"` | Sets logging verbosity. Log levels are OFF, FATAL, WARN, INFO, DEBUG, TRACE, ALL. |
| metricsPort | int | `9000` | The port (TCP) on which Prometheus accesses metrics  |
| nameOverride | string | `""` | Provide a name in place of operator for `app:` labels  |
| network | string | `"mainnet"` | Network Options: mainnet, prater, gnosis |
| nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| podAnnotations | object | `{}` |  |
| pruningEpochToKeep | int | `100` | Number of epochs to keep when pruning the slashing protection database.  |
| pruningInterval | int | `24` | Hours between slashing protection database pruning operations.  |
| replicaCount | int | `3` |  |
| resources | object | `{}` | Configure resource requests and limits. ref: http://kubernetes.io/docs/user-guide/compute-resources/  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount | object | `{"annotations":{},"name":""}` | ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"additionalLabels":{},"enabled":false,"honorLabels":false,"interval":"30s","metricRelabelings":[],"namespace":"","relabellings":[],"scrapeTimeout":""}` | Prometheus Service Monitor ref: https://github.com/coreos/prometheus-operator      https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint  |
| serviceMonitor.additionalLabels | object | `{}` | Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus  |
| serviceMonitor.enabled | bool | `false` | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator  |
| serviceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint  |
| serviceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped  |
| serviceMonitor.metricRelabelings | list | `[]` | Metrics RelabelConfigs to apply to samples before ingestion.  |
| serviceMonitor.namespace | string | `""` | The namespace in which the ServiceMonitor will be created  |
| serviceMonitor.relabellings | list | `[]` | Metrics RelabelConfigs to apply to samples before scraping.  |
| serviceMonitor.scrapeTimeout | string | `""` | The timeout after which the scrape is ended  |
| slotsPerEpoch | int | `32` | Number of slots per epoch. This number multiplied by the number of epochs to keep determines what blocks to keep when pruning the slashing protection database. The default is 32 as defined on MainNet/Prater.  |
| tmpfsSize | string | `"128Mi"` |  |
| tolerations | object | `{}` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/  |
| web3signerJavaOpts | string | `"-Xmx1g -Xms1g"` | Java Opts  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
