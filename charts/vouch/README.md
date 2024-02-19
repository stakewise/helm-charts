# vouch

![Version: 1.1.1](https://img.shields.io/badge/Version-1.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.6](https://img.shields.io/badge/AppVersion-1.7.6-informational?style=flat-square)

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
| cliImage.pullPolicy | string | `"IfNotPresent"` |  |
| cliImage.repository | string | `"nethermindeth/keystores-cli"` |  |
| cliImage.tag | string | `"v1.0.0"` |  |
| externalSecrets.dataFrom.key | string | `"vouch"` |  |
| externalSecrets.enabled | bool | `false` |  |
| externalSecrets.secretStoreRef.kind | string | `"SecretStore"` |  |
| externalSecrets.secretStoreRef.name | string | `"secretStoreRef"` |  |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources  |
| global.serviceAccount.create | bool | `true` |  |
| httpPort | int | `8881` | Port on which vouch HTTP listens.  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"attestant/vouch"` |  |
| image.tag | string | `"1.7.6"` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| initImage | object | `{"pullPolicy":"IfNotPresent","repository":"bash","tag":"5.2"}` | Init image is used to chown data volume, etc.  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.httpGet.port | string | `"metrics"` |  |
| livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `3` |  |
| loggingLevel | string | `"INFO"` | Sets logging verbosity. Log levels are OFF, FATAL, WARN, INFO, DEBUG, TRACE, ALL. |
| metricsPort | int | `8081` | The port (TCP) on which Prometheus accesses metrics  |
| nameOverride | string | `""` | Provide a name in place of operator for `app:` labels  |
| nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{"fsGroup":1000,"runAsUser":1000}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/metrics"` |  |
| readinessProbe.httpGet.port | string | `"metrics"` |  |
| readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `5` |  |
| readinessProbe.successThreshold | int | `2` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| relays | list | `[]` |  |
| resources | object | `{}` | Configure resource requests and limits. ref: http://kubernetes.io/docs/user-guide/compute-resources/  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.fsGroup | int | `10000` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `10000` |  |
| service.httpPort | int | `8881` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount | object | `{"annotations":{},"name":""}` | ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"additionalLabels":{},"enabled":false,"honorLabels":false,"interval":"30s","metricRelabelings":[],"namespace":"","relabellings":[],"scrapeTimeout":""}` | Prometheus Service Monitor ref: https://github.com/coreos/prometheus-operator      https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint  |
| serviceMonitor.additionalLabels | object | `{}` | Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus  |
| serviceMonitor.enabled | bool | `false` | ServiceMonitor resource(s) for scraping metrics using PrometheusOperator  |
| serviceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint  |
| serviceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped  |
| serviceMonitor.metricRelabelings | list | `[]` | Metrics RelabelConfigs to apply to samples before ingestion.  |
| serviceMonitor.namespace | string | `""` | The namespace in which the ServiceMonitor will be created  |
| serviceMonitor.relabellings | list | `[]` | RelabelConfigs to apply to samples before scraping.  |
| serviceMonitor.scrapeTimeout | string | `""` | The timeout after which the scrape is ended  |
| tolerations | object | `{}` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/  |
| vouch.accountmanager.dirk.accounts[0] | string | `"Validators"` |  |
| vouch.accountmanager.dirk.endpoints[0] | string | `"dirk-1:8881"` |  |
| vouch.accountmanager.dirk.endpoints[1] | string | `"dirk-2:8881"` |  |
| vouch.accountmanager.dirk.endpoints[2] | string | `"dirk-3:8881"` |  |
| vouch.accountmanager.dirk.timeout | string | `"1m"` |  |
| vouch.beaconnodeaddress | string | `"localhost:5052"` |  |
| vouch.beaconnodeaddresses[0] | string | `"localhost:5051"` |  |
| vouch.beaconnodeaddresses[1] | string | `"localhost:5052"` |  |
| vouch.blockrelay.fallbackfeerecipient | string | `"0x0000000000000000000000000000000000000001"` |  |
| vouch.feerecipient.defaultaddress | string | `"0x0000000000000000000000000000000000000001"` |  |
| vouch.graffiti.static.value | string | `"My graffiti"` |  |
| vouch.loglevel | string | `"debug"` |  |
| vouch.metrics.prometheus.listenaddress | string | `"0.0.0.0:8081"` |  |
| vouch.metrics.prometheus.loglevel | string | `"trace"` |  |
| vouch.strategies | string | `nil` |  |
| vouch.submitter | string | `nil` |  |
| vouch.tracing | string | `nil` |  |
| vouchDataDir | string | `"/data/vouch"` |  |
| vouchFullConfig | string | `nil` | use vouchFullConfig: to provide all vouch.yaml values use vouch: to populate good defaults and to do minimal changes |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
