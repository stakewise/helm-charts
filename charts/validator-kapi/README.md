# validator-kapi

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.1](https://img.shields.io/badge/AppVersion-v0.0.1-informational?style=flat-square)

A Helm chart for installing and configuring Lido's validator-kapi

**Homepage:** <https://nethermind.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| matilote |  |  |
| aivarasko |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami/ | postgresql | 13.2.23 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity  |
| global.externalSecrets.data[0].remoteRef.key | string | `"validatorKapiSecrets"` |  |
| global.externalSecrets.data[0].remoteRef.property | string | `"dbName"` |  |
| global.externalSecrets.data[0].secretKey | string | `"DB_NAME"` |  |
| global.externalSecrets.data[1].remoteRef.key | string | `"validatorKapiSecrets"` |  |
| global.externalSecrets.data[1].remoteRef.property | string | `"dbPort"` |  |
| global.externalSecrets.data[1].secretKey | string | `"DB_PORT"` |  |
| global.externalSecrets.data[2].remoteRef.key | string | `"validatorKapiSecrets"` |  |
| global.externalSecrets.data[2].remoteRef.property | string | `"dbHost"` |  |
| global.externalSecrets.data[2].secretKey | string | `"DB_HOST"` |  |
| global.externalSecrets.data[3].remoteRef.key | string | `"validatorKapiSecrets"` |  |
| global.externalSecrets.data[3].remoteRef.property | string | `"dbUser"` |  |
| global.externalSecrets.data[3].secretKey | string | `"DB_USER"` |  |
| global.externalSecrets.data[4].remoteRef.key | string | `"validatorKapiSecrets"` |  |
| global.externalSecrets.data[4].remoteRef.property | string | `"dbPassword"` |  |
| global.externalSecrets.data[4].secretKey | string | `"DB_PASSWORD"` |  |
| global.externalSecrets.enabled | bool | `false` |  |
| global.externalSecrets.secretStoreRef | string | `"secretStoreRef"` |  |
| global.image.pullPolicy | string | `"IfNotPresent"` |  |
| global.image.repository | string | `"lidofinance/lido-keys-api"` |  |
| global.image.tag | string | `"0.10.1"` |  |
| global.replicaCount | int | `1` |  |
| global.serviceAccount.create | bool | `true` |  |
| kapi.chainId | int | `1` | chain id |
| kapi.consensus | string | `"http://your_cl_node1,http://your_cl_node2"` | CL api urls if VALIDATOR_REGISTRY_ENABLE=false , there are no need to provide CL_API_URLS |
| kapi.corsWhitelistRegexp | string | `""` | The number of seconds that each request will last in storage |
| kapi.env | string | `"production"` |  |
| kapi.execution | string | `"http://your_el_node1,http://your_el_node2"` | EL Node provider You could provide few providers for fallback |
| kapi.globalCacheTTL | int | `1` | Cache expiration time in seconds |
| kapi.globalThrottleLimit | int | `100` | The maximum number of requests within the TTL limit |
| kapi.globlaThrottleTTL | int | `5` |  |
| kapi.jobIntervalRegistry | string | `"*/5 * * * * *"` |  |
| kapi.jobIntervalValidatorsRegistry | string | `"*/10 * * * * *"` |  |
| kapi.logFormat | string | `"json"` | Log format: simple or json |
| kapi.logLevel | string | `"debug"` | Log level: debug, info, notice, warning or error |
| kapi.port | int | `3000` | Application port |
| kapi.providerBatchAggregationWaitMs | int | `10` |  |
| kapi.providerConcurrentRequests | int | `5` |  |
| kapi.providerJsonRpcMaxBatchSize | int | `100` | FallbackProviderModule request policy parameters values below are default |
| kapi.validatorRegistryEnable | bool | `true` | It is possible to enable/disable collecting of validators value below is default |
| nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| postgresql | object | `{"audit":{"logHostname":true},"auth":{"database":"kapi","existingSecret":"eso-validator-kapi","secretKeys":{"adminPasswordKey":"DB_PASSWORD","replicationPasswordKey":"","userPasswordKey":"DB_PASSWORD"},"username":"postgres"},"containerSecurityContext":{"enabled":true,"runAsUser":1001},"enabled":true,"hostname":"postgresql","metrics":{"enabled":true},"networkPolicy":{"enabled":false},"primary":{"persistence":{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"mountPath":"/bitnami/postgresql","selector":{},"size":"20Gi","subPath":""},"resources":{"requests":{"cpu":"250m","memory":"384Mi"}}},"rbac":{"create":false},"securityContext":{"enabled":true,"fsGroup":1001},"service":{"ports":{"postgresql":5432}},"tls":{"enabled":false},"volumePermissions":{"enabled":true,"image":{"pullPolicy":"Always","registry":"docker.io","repository":"bitnami/bitnami-shell","tag":"11-debian-11-r99"},"securityContext":{"runAsUser":0}}}` | PostgreSQL Server ref: https://github.com/bitnami/charts/tree/master/bitnami/postgresql  |
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
