# validators

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.0.0](https://img.shields.io/badge/AppVersion-v1.0.0-informational?style=flat-square)

A Helm chart for installing validators with the web3signer.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| matilote |  |  |
| aivarasko |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity  |
| beaconChainRpcEndpoints | list | `[]` | List of Beacon Chain node addresses  |
| beaconChainRpcEndpointsRandomized | list | `[]` | Randomize endpoints if specified Has a higher priority than beaconChainRpcEndpoints, all specified hosts will be randomly assigned to all validators, used to more evenly distribute the load  |
| cliImage | object | `{"pullPolicy":"IfNotPresent","repository":"nethermindeth/keystores-cli","tag":"v1.0.0"}` | CLI image is used to fetch public keys.  |
| enableBuilder | bool | `false` | Whether a builder should be used for proposalConfig |
| enableWatcher | bool | `false` |  |
| enabled | bool | `true` | Whether to enable validator statefulset or not Can be used to temporarily disable validators until synchronization of eth1/eth2 nodes is complete  |
| externalSecrets.data | list | `[]` |  |
| externalSecrets.enabled | bool | `true` |  |
| externalSecrets.secretStoreRef.kind | string | `"secretStoreKind"` |  |
| externalSecrets.secretStoreRef.name | string | `"secretStoreName"` |  |
| extraFlags | object | `{"lighthouse":[],"lodestar":[],"nimbus":[],"prysm":[],"teku":[]}` | Validators extra flags  |
| fallbackRpcEndpoints | list | `[]` | If using beaconChainRpcEndpointsRandomized fallbackRpcEndpoints will be appended to the list always serving as the last, failover endpoint  |
| flags | object | `{"lighthouse":["lighthouse","vc","--datadir=/data/lighthouse","--init-slashing-protection","--logfile-compress","--logfile-max-size=64","--logfile-max-number=2"],"lodestar":["validator","--dataDir=/data/lodestar","--logLevel=info"],"nimbus":["--data-dir=/data/nimbus","--non-interactive","--log-level=INFO","--doppelganger-detection=off"],"prysm":["--datadir=/data/prysm","--accept-terms-of-use","--disable-rewards-penalties-logging","--disable-account-metrics"],"teku":["validator-client","--log-destination=CONSOLE","--data-base-path=/data"]}` | Validators flags  |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources  |
| global.imagePullSecrets | list | `[]` |  |
| global.network | string | `"mainnet"` |  |
| global.owner | string | `""` |  |
| global.podSecurityContext | object | `{"fsGroup":10000,"runAsNonRoot":true,"runAsUser":10000}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| global.project | string | `""` |  |
| global.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| global.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| global.securityContext.runAsNonRoot | bool | `true` |  |
| global.securityContext.runAsUser | int | `10000` |  |
| graffiti | string | `""` | You can use the graffiti to add a string to your proposed blocks, which will be seen on the block explorer. ref: https://docs.prylabs.network/docs/prysm-usage/parameters#validator-configuration  |
| image | object | `{"lighthouse":{"repository":"sigp/lighthouse","tag":"v4.5.0"},"lodestar":{"repository":"chainsafe/lodestar","tag":"v1.12.0"},"nimbus":{"repository":"statusim/nimbus-validator-client","tag":"multiarch-v23.11.0"},"prysm":{"repository":"gcr.io/prylabs-dev/prysm/validator","tag":"v4.1.1"},"pullPolicy":"IfNotPresent","teku":{"repository":"consensys/teku","tag":"23.11.0"}}` | Validators image version ref: https://gcr.io/prysmaticlabs/prysm/validator ref: https://hub.docker.com/r/sigp/lighthouse |
| imagePullSecrets | list | `[]` | Credentials to fetch images from private registry ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/  |
| initImageBusybox | object | `{"pullPolicy":"IfNotPresent","repository":"busybox","tag":"1.36"}` | Init image is used to chown data volume, initialise genesis, etc.  |
| livenessProbe.lighthouse.failureThreshold | int | `3` |  |
| livenessProbe.lighthouse.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.lighthouse.httpGet.port | string | `"metrics"` |  |
| livenessProbe.lighthouse.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.lighthouse.initialDelaySeconds | int | `60` |  |
| livenessProbe.lighthouse.periodSeconds | int | `60` |  |
| livenessProbe.lighthouse.successThreshold | int | `1` |  |
| livenessProbe.lighthouse.timeoutSeconds | int | `1` |  |
| livenessProbe.lodestar.failureThreshold | int | `3` |  |
| livenessProbe.lodestar.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.lodestar.httpGet.port | string | `"metrics"` |  |
| livenessProbe.lodestar.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.lodestar.initialDelaySeconds | int | `60` |  |
| livenessProbe.lodestar.periodSeconds | int | `60` |  |
| livenessProbe.lodestar.successThreshold | int | `1` |  |
| livenessProbe.lodestar.timeoutSeconds | int | `1` |  |
| livenessProbe.nimbus.failureThreshold | int | `3` |  |
| livenessProbe.nimbus.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.nimbus.httpGet.port | string | `"metrics"` |  |
| livenessProbe.nimbus.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.nimbus.initialDelaySeconds | int | `60` |  |
| livenessProbe.nimbus.periodSeconds | int | `60` |  |
| livenessProbe.nimbus.successThreshold | int | `1` |  |
| livenessProbe.nimbus.timeoutSeconds | int | `1` |  |
| livenessProbe.prysm.failureThreshold | int | `3` |  |
| livenessProbe.prysm.httpGet.path | string | `"/healthz"` |  |
| livenessProbe.prysm.httpGet.port | string | `"metrics"` |  |
| livenessProbe.prysm.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.prysm.initialDelaySeconds | int | `60` |  |
| livenessProbe.prysm.periodSeconds | int | `60` |  |
| livenessProbe.prysm.successThreshold | int | `1` |  |
| livenessProbe.prysm.timeoutSeconds | int | `1` |  |
| livenessProbe.teku.failureThreshold | int | `3` |  |
| livenessProbe.teku.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.teku.httpGet.port | string | `"metrics"` |  |
| livenessProbe.teku.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.teku.initialDelaySeconds | int | `60` |  |
| livenessProbe.teku.periodSeconds | int | `60` |  |
| livenessProbe.teku.successThreshold | int | `1` |  |
| livenessProbe.teku.timeoutSeconds | int | `1` |  |
| metrics | object | `{"enabled":true,"flags":{"lighthouse":["--metrics","--metrics-port=9090","--metrics-address=0.0.0.0"],"lodestar":["--metrics","--metrics.address=0.0.0.0","--metrics.port=9090"],"nimbus":["--metrics","--metrics-port=9090","--metrics-address=0.0.0.0"],"prysm":["--monitoring-port=9090","--monitoring-host=0.0.0.0"],"teku":["--metrics-enabled=true","--metrics-host-allowlist=*","--metrics-interface=0.0.0.0","--metrics-port=9090"]},"port":9090,"prometheusRule":{"additionalLabels":{},"default":true,"enabled":false,"namespace":"","rules":{}},"serviceMonitor":{"additionalLabels":{},"enabled":false,"honorLabels":false,"interval":"30s","metricRelabelings":[],"namespace":"","relabelings":[],"scrapeTimeout":""}}` | Monitoring  |
| metrics.enabled | bool | `true` | Whether to enable metrics collection or not |
| metrics.flags | object | `{"lighthouse":["--metrics","--metrics-port=9090","--metrics-address=0.0.0.0"],"lodestar":["--metrics","--metrics.address=0.0.0.0","--metrics.port=9090"],"nimbus":["--metrics","--metrics-port=9090","--metrics-address=0.0.0.0"],"prysm":["--monitoring-port=9090","--monitoring-host=0.0.0.0"],"teku":["--metrics-enabled=true","--metrics-host-allowlist=*","--metrics-interface=0.0.0.0","--metrics-port=9090"]}` | Extra flags to pass for collecting metrics |
| metrics.port | int | `9090` | Prometheus exporter port |
| metrics.prometheusRule | object | `{"additionalLabels":{},"default":true,"enabled":false,"namespace":"","rules":{}}` | Custom PrometheusRule to be defined ref: https://github.com/coreos/prometheus-operator#customresourcedefinitions  |
| metrics.prometheusRule.additionalLabels | object | `{}` | Additional labels for the prometheusRule  |
| metrics.prometheusRule.default | bool | `true` | Create a default set of Alerts  |
| metrics.prometheusRule.enabled | bool | `false` | Create a custom prometheusRule Resource for scraping metrics using PrometheusOperator  |
| metrics.prometheusRule.namespace | string | `""` | The namespace in which the prometheusRule will be created  |
| metrics.prometheusRule.rules | object | `{}` | Custom Prometheus rules |
| metrics.serviceMonitor | object | `{"additionalLabels":{},"enabled":false,"honorLabels":false,"interval":"30s","metricRelabelings":[],"namespace":"","relabelings":[],"scrapeTimeout":""}` | Prometheus Service Monitor ref: https://github.com/coreos/prometheus-operator      https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint  |
| metrics.serviceMonitor.additionalLabels | object | `{}` | Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus  |
| metrics.serviceMonitor.enabled | bool | `false` | ServiceMonitor resource(s) for scraping metrics using PrometheusOperator  |
| metrics.serviceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint  |
| metrics.serviceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped  |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Metrics RelabelConfigs to apply to samples before ingestion.  |
| metrics.serviceMonitor.namespace | string | `""` | The namespace in which the ServiceMonitor will be created  |
| metrics.serviceMonitor.relabelings | list | `[]` | Metrics RelabelConfigs to apply to samples before scraping.  |
| metrics.serviceMonitor.scrapeTimeout | string | `""` | The timeout after which the scrape is ended  |
| nameOverride | string | `""` | Provide a name in place of operator for `app:` labels  |
| network | string | `"mainnet"` | Network ID Options for Ethereum: mainnet, prater Options for Gnosis: gnosis  |
| nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| priorityClassName | string | `""` | used to assign priority to pods ref: https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/  |
| rbac | object | `{"create":true,"name":"","rules":[{"apiGroups":[""],"resources":["services","pods"],"verbs":["list","get","patch"]}]}` | RBAC configuration. ref: https://kubernetes.io/docs/reference/access-authn-authz/rbac/  |
| readinessProbe | object | `{"lighthouse":{"failureThreshold":3,"httpGet":{"path":"/metrics","port":"metrics","scheme":"HTTP"},"initialDelaySeconds":60,"periodSeconds":60,"successThreshold":1,"timeoutSeconds":1},"lodestar":{"failureThreshold":3,"httpGet":{"path":"/metrics","port":"metrics","scheme":"HTTP"},"initialDelaySeconds":60,"periodSeconds":60,"successThreshold":1,"timeoutSeconds":1},"nimbus":{"failureThreshold":3,"httpGet":{"path":"/metrics","port":"metrics","scheme":"HTTP"},"initialDelaySeconds":60,"periodSeconds":60,"successThreshold":1,"timeoutSeconds":1},"prysm":{"failureThreshold":3,"httpGet":{"path":"/healthz","port":"metrics","scheme":"HTTP"},"initialDelaySeconds":60,"periodSeconds":60,"successThreshold":1,"timeoutSeconds":1},"teku":{"failureThreshold":3,"httpGet":{"path":"/metrics","port":"metrics","scheme":"HTTP"},"initialDelaySeconds":60,"periodSeconds":60,"successThreshold":1,"timeoutSeconds":1}}` | Configure liveness and readiness probes https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/  |
| resources | object | `{}` | Configure resource requests and limits. ref: http://kubernetes.io/docs/user-guide/compute-resources/  |
| serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Spearate service account per validator. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| strictFeeRecipientCheck | bool | `false` | Lodestar specific setting Enables strict checking of the validator's feeRecipient with the one returned by engine |
| terminationGracePeriodSeconds | int | `120` |  |
| tolerations | object | `{}` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/  |
| type | string | `"teku"` | What type of validator to use. Options for Ethereum: prysm, lighthouse, teku, nimbus, lodestar Options for Gnosis: teku, lighthouse, nimbus  |
| validatorsCount | int | `0` | How many validators to run **NB! Each validtor hosts a certain number of keys specified when using CLI sync-db command, so the number of validators must be >= (total number of validator keys) / validator capacity specified in CLI  |
| validatorsKeyIndex | int | `0` | If you want to run multiple validator types (e.g lighouse, teku,...) you need to adjust the key index to prevent double signing. Please be careful with this setting and be aware of boundaries of each validator client you would like to run.  Example: - 700 Keys in Web3Signer database - 4 Lighthouse validators - 3 Prysm validators  Deployment 1 => validatorsKeyIndex: 0                 validatorsCount: 4                 type: lighthouse  Deployment 2 => validatorsKeyIndex: 4                 validatorsCount: 3                 type: prysm  **NB! If you not fully understand what is done here, keep this value at 0 and set validatorsCount to the maximum of your keys and do not spin up this Chart multiple times! |
| validatorsNoOfKeys | int | `100` |  |
| web3signerEndpoint | string | `""` | Web3Signer Endpoint  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
