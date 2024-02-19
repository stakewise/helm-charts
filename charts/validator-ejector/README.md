# validator-ejector

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.1](https://img.shields.io/badge/AppVersion-v0.0.1-informational?style=flat-square)

A Helm chart for installing and configuring Lido's validator-ejector

**Homepage:** <https://nethermind.io/>

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
| ejector.blocksLoop | int | `32` | Amount of blocks to load events from on every poll. Defaults to 1 epoch |
| ejector.blocksPreload | int | `7200` | Amount of blocks to load events from on start. Increase if daemon was not running for some time. Defaults to a day of blocks |
| ejector.consensus | string | `"http://localhost:4000"` | Ethereum Consensus Node endpoint |
| ejector.dryRun | bool | `false` | Run the service without actually sending out exit messages |
| ejector.execution | string | `"http://localhost:8545"` | Ethereum Execution Node endpoint |
| ejector.httpPort | int | `2122` | Port to serve metrics and health check on |
| ejector.jobInterval | int | `384000` | Time interval in milliseconds to run checks. Defaults to time of 1 epoch |
| ejector.locatorAddress | string | `"0x12cd349E19Ab2ADBE478Fc538A66C059Cf40CFeC"` | Address of the Locator contract, can be found in the lido-dao repo |
| ejector.loggerFormat | string | `"simple"` | Simple or JSON log output: simple/json |
| ejector.loggerLevel | string | `"info"` | Severity level from which to start showing errors eg info will hide debug messages |
| ejector.messagesLocation | string | `"messages"` | Folder to load json exit message files from |
| ejector.operatorId | string | `"123"` | Operator ID in the Node Operators registry, easiest to get from Operators UI |
| ejector.runHealthCheck | bool | `true` | Enable health check endpoint |
| ejector.runMetrics | bool | `true` | Enable metrics endpoint |
| ejector.stakingModuleId | string | `"123"` | Staking Module ID for which operator ID is set |
| ejector.validatorExitWebhook | string | `""` | POST validator info to an endpoint instead of sending out an exit message in order to initiate an exit. Required if you are using webhook mode |
| global.externalSecrets.data[0].remoteRef.key | string | `"validatorEjectorSecrets"` |  |
| global.externalSecrets.data[0].remoteRef.property | string | `"message"` |  |
| global.externalSecrets.data[0].secretKey | string | `"MESSAGES_PASSWORD"` |  |
| global.externalSecrets.data[1].remoteRef.key | string | `"validatorEjectorSecrets"` |  |
| global.externalSecrets.data[1].remoteRef.property | string | `"loggerSecrets"` |  |
| global.externalSecrets.data[1].secretKey | string | `"LOGGER_SECRETS"` |  |
| global.externalSecrets.data[2].remoteRef.key | string | `"validatorEjectorSecrets"` |  |
| global.externalSecrets.data[2].remoteRef.property | string | `"oracleAddressesAllowlist"` |  |
| global.externalSecrets.data[2].secretKey | string | `"ORACLE_ADDRESSES_ALLOWLIST"` |  |
| global.externalSecrets.enabled | bool | `false` |  |
| global.externalSecrets.secretStoreRef | string | `"secretStoreRef"` |  |
| global.image.pullPolicy | string | `"IfNotPresent"` |  |
| global.image.repository | string | `"lidofinance/validator-ejector"` |  |
| global.image.tag | string | `"1.2.0"` |  |
| global.initImage.pullPolicy | string | `"IfNotPresent"` |  |
| global.initImage.repository | string | `"bitnami/kubectl"` |  |
| global.initImage.tag | string | `"1.28"` |  |
| global.loader.pullPolicy | string | `"IfNotPresent"` |  |
| global.loader.repository | string | `"nethermindeth/eth-exit-messages"` |  |
| global.loader.tag | string | `"v0.0.26"` |  |
| global.replicaCount | int | `1` |  |
| global.serviceAccount.create | bool | `true` |  |
| loader.BEACON_ENDPOINT | string | `"http://192.168.11.104:5052"` |  |
| loader.CUSTODIAN_WEB3SIGNER_MAPPER | string | `"{\"custodian1/second\": \"http://192.168.11.104:9110\"}"` |  |
| loader.EIP2335_PASSWORD | string | `"test"` |  |
| loader.ENCRYPTION | string | `"EIP2335"` |  |
| loader.ENCRYPTION_TYPE | string | `"EIP2335"` |  |
| loader.ENCRYPT_WITH_METADATA | string | `"false"` |  |
| loader.FETCH_INTERVAL | string | `"60"` |  |
| loader.KEY_LOADER_TYPE | string | `"WEB3SIGNER"` |  |
| loader.LOADER_MAPPER | string | `"{}"` |  |
| loader.LidoKAPI_KEYS_PERCENT | string | `"5"` |  |
| loader.LidoKAPI_OPERATOR_ID | string | `""` |  |
| loader.SIGNER_MAPPER | string | `"{}"` |  |
| loader.STORAGE_LOCATION | string | `"local/"` |  |
| nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"size":"5Gi","storageClassName":""}` | Whether or not to allocate persistent volume disk for the data directory. In case of node failure, the node data directory will still persist.  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| resources | object | `{}` | Configure resource requests and limits. ref: http://kubernetes.io/docs/user-guide/compute-resources/  |
| securityContext | object | `{}` |  |
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
| tolerations | object | `{}` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
