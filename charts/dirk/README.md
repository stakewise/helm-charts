# dirk

![Version: 1.1.1](https://img.shields.io/badge/Version-1.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v22.10.0](https://img.shields.io/badge/AppVersion-v22.10.0-informational?style=flat-square)

A Helm chart for installing and configuring large scale ETH staking infrastructure on top of the Kubernetes

**Homepage:** <https://stakewise.io/>

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
| dirk.clientName | string | `"client1"` |  |
| dirk.fetchKeysExtraFlags | list | `[]` |  |
| dirk.loglevel | string | `"Debug"` |  |
| dirk.tracing | string | `nil` |  |
| externalSecrets.dataFrom.key | string | `"dirk"` |  |
| externalSecrets.enabled | bool | `false` |  |
| externalSecrets.secretStoreRef.kind | string | `"SecretStore"` |  |
| externalSecrets.secretStoreRef.name | string | `"secretStoreRef"` |  |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources  |
| global.podSecurityContext | object | `{"fsGroup":10000,"runAsNonRoot":true,"runAsUser":10000}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| global.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| global.securityContext.fsGroup | int | `10000` |  |
| global.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| global.securityContext.runAsNonRoot | bool | `true` |  |
| global.securityContext.runAsUser | int | `10000` |  |
| global.serviceAccount.create | bool | `true` |  |
| httpPort | int | `8881` | Port on which dirk HTTP listens.  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"attestant/dirk"` |  |
| image.tag | string | `"1.2.0"` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| initImage | object | `{"pullPolicy":"IfNotPresent","repository":"bash","tag":"5.2"}` | Init image is used to chown data volume, etc.  |
| livenessProbe.exec.command[0] | string | `"/bin/bash"` |  |
| livenessProbe.exec.command[1] | string | `"/scripts/liveness_probe.sh"` |  |
| livenessProbe.failureThreshold | int | `1` |  |
| livenessProbe.periodSeconds | int | `90` |  |
| loggingLevel | string | `"INFO"` | Sets logging verbosity. Log levels are OFF, FATAL, WARN, INFO, DEBUG, TRACE, ALL. |
| metricsPort | int | `9000` | The port (TCP) on which Prometheus accesses metrics  |
| minReadySeconds | int | `10` |  |
| nameOverride | string | `""` | Provide a name in place of operator for `app:` labels  |
| nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| podAnnotations | object | `{}` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/metrics"` |  |
| readinessProbe.httpGet.port | string | `"metrics"` |  |
| readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `1` |  |
| readinessProbe.successThreshold | int | `3` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| replicaCount | int | `3` |  |
| resources | object | `{}` | Configure resource requests and limits. ref: http://kubernetes.io/docs/user-guide/compute-resources/  |
| service.httpPort | int | `8881` |  |
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
| serviceMonitor.relabellings | list | `[]` | RelabelConfigs to apply to samples before scraping.  |
| serviceMonitor.scrapeTimeout | string | `""` | The timeout after which the scrape is ended  |
| tolerations | object | `{}` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
