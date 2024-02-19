# execution-beacon

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart that combines Kubernetes manifests and scripts to deploy Ethereum full-nodes without validators with top-notch performance as the goal.

**Homepage:** <https://www.ethereum.org/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| matilote |  |  |
| aivarasko |  |  |
| AntiD2ta |  |  |

## Requirements

Kubernetes: `^1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://../common | common | 1.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| beacon.builderEndpoint | string | `""` | MEV Boost endpoint |
| beacon.checkPointSync | object | `{"enabled":true,"trustedSourceUrl":"","url":"https://mainnet-checkpoint-sync.attestant.io"}` | To get Beacon node up and running in only a few minutes from a recent finalized checkpoint state rather than syncing from genesis.  |
| beacon.client | string | `"nimbus"` |  |
| beacon.extraFlags | list | `[]` | Extra flags to pass to the node |
| beacon.grpc.enabled | bool | `true` |  |
| beacon.grpc.host | string | `"0.0.0.0"` |  |
| beacon.grpc.port | int | `4000` |  |
| beacon.grpc.portName | string | `"rpc"` |  |
| beacon.initChownData | bool | `true` | If false, data ownership will not be reset at startup This allows the beacon node to be run with an arbitrary user  |
| beacon.javaOpts | object | `{"enabled":true,"maxHeapSize":"-Xmx3g"}` | Teku specific setting |
| beacon.javaOpts.maxHeapSize | string | `"-Xmx3g"` | This option is used to set java specific values for heap size and should be used if you experience out of memory errors. The Xmx option stands for the maximum memory allocation pool for a Java Virtual Machine ( JVM ). https://besu.hyperledger.org/en/stable/public-networks/how-to/configure-jvm/manage-memory/ |
| beacon.metrics.annotations | object | `{}` |  |
| beacon.metrics.categories | list | `["JVM","PROCESS","BEACON","DISCOVERY","EVENTBUS","EXECUTOR","NETWORK","STORAGE","STORAGE_HOT_DB","STORAGE_FINALIZED_DB","REMOTE_VALIDATOR","VALIDATOR","VALIDATOR_PERFORMANCE"]` | Monitoring Teku Metric categories to enable |
| beacon.metrics.enabled | bool | `true` | Whether to enable metrics collection or not |
| beacon.metrics.host | string | `"0.0.0.0"` |  |
| beacon.metrics.hostAllowList | list | `["*"]` | List of hostnames to allow, or * to allow any host |
| beacon.metrics.port | int | `9090` |  |
| beacon.metrics.prometheusRule | object | `{"enabled":true}` | Custom PrometheusRule to be defined ref: https://github.com/coreos/prometheus-operator#customresourcedefinitions  |
| beacon.metrics.prometheusRule.enabled | bool | `true` | Create a custom prometheusRule Resource for scraping metrics using PrometheusOperator |
| beacon.metrics.serviceMonitor | object | `{"enabled":true}` | Prometheus Service Monitor ref: https://github.com/coreos/prometheus-operator      https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint  |
| beacon.metrics.serviceMonitor.enabled | bool | `true` | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator |
| beacon.persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"size":"100Gi","storageClassName":""}` | Whether or not to allocate persistent volume disk for the data directory. In case of node failure, the node data directory will still persist.  |
| beacon.proposerOnly | bool | `false` | Lighthouse specific setting |
| beacon.resources | object | `{}` |  |
| beacon.restApi | object | `{"corsOrigins":["*"],"enabled":true,"host":"0.0.0.0","hostAllowList":["*"],"portMap":{"lighthouse":5052,"lodestar":9596,"nimbus":5052,"prysm":8080,"teku":5051}}` | Rest API Settings |
| beacon.restApi.enabled | bool | `true` | Enables Beacon Rest API |
| beacon.restApi.hostAllowList | list | `["*"]` | Comma-separated list of hostnames to allow, or * to allow any host |
| beacon.restApi.portMap | object | `{"lighthouse":5052,"lodestar":9596,"nimbus":5052,"prysm":8080,"teku":5051}` | Port number of Beacon Rest API |
| beacon.suggestedFeeRecipient | string | `""` | Post bellatrix, this address will receive the transaction fees produced by any blocks from this node. Default to junk whilst bellatrix is in development state. Validator client can override this value through the preparebeaconproposer api.  |
| beacon.targetPeers | int | `50` |  |
| beacon.targetPeersMin | int | `40` |  |
| beacon.totalDifficultyOverride | string | `""` | Sets the total difficulty to manual overrides the default TERMINAL_TOTAL_DIFFICULTY value. WARNING: This flag should be used only if you have a clear understanding that community has decided to override the terminal difficulty. Incorrect usage will result in your node experience consensus failure.  |
| execution.client | string | `"nethermind"` |  |
| execution.extraFlags | list | `[]` | Extra flags to pass to the node |
| execution.healthchecks | object | `{"enabled":true,"lowStorageSpaceShutdownThreshold":0,"lowStorageSpaceWarningThreshold":5,"pollingInterval":5,"slug":"/health"}` | Nethermind HealthChecks module |
| execution.initChownData | bool | `true` | If false, data ownership will not be reset at startup This allows the execution node to be run with an arbitrary user  |
| execution.javaOpts | object | `{"enabled":false,"maxHeapSize":""}` | Besu specific setting |
| execution.javaOpts.maxHeapSize | string | `""` | This option is used to set java specific values for heap size and should be used if you experience out of memory errors. The Xmx option stands for the maximum memory allocation pool for a Java Virtual Machine ( JVM ). https://besu.hyperledger.org/en/stable/public-networks/how-to/configure-jvm/manage-memory/ |
| execution.jsonrpc.enabled | bool | `true` |  |
| execution.jsonrpc.engine.corsOrigins[0] | string | `"*"` |  |
| execution.jsonrpc.engine.hostAllowList[0] | string | `"*"` |  |
| execution.jsonrpc.engine.port | int | `8551` |  |
| execution.jsonrpc.grpc.port | int | `9090` |  |
| execution.jsonrpc.host | string | `"0.0.0.0"` |  |
| execution.jsonrpc.http.corsOrigins[0] | string | `"*"` |  |
| execution.jsonrpc.http.hostAllowList[0] | string | `"*"` |  |
| execution.jsonrpc.http.port | int | `8545` |  |
| execution.jsonrpc.namespaces.erigon[0] | string | `"eth"` |  |
| execution.jsonrpc.namespaces.erigon[1] | string | `"erigon"` |  |
| execution.jsonrpc.namespaces.erigon[2] | string | `"web3"` |  |
| execution.jsonrpc.namespaces.erigon[3] | string | `"net"` |  |
| execution.jsonrpc.namespaces.erigon[4] | string | `"engine"` |  |
| execution.jsonrpc.namespaces.geth[0] | string | `"web3"` |  |
| execution.jsonrpc.namespaces.geth[1] | string | `"eth"` |  |
| execution.jsonrpc.namespaces.geth[2] | string | `"net"` |  |
| execution.jsonrpc.namespaces.geth[3] | string | `"engine"` |  |
| execution.jsonrpc.namespaces.nethermind[0] | string | `"Web3"` |  |
| execution.jsonrpc.namespaces.nethermind[1] | string | `"Eth"` |  |
| execution.jsonrpc.namespaces.nethermind[2] | string | `"Net"` |  |
| execution.jsonrpc.namespaces.nethermind[3] | string | `"Subscribe"` |  |
| execution.jsonrpc.namespaces.nethermind[4] | string | `"Health"` |  |
| execution.jsonrpc.websocket.enabled | bool | `true` |  |
| execution.jsonrpc.websocket.origins | string | `"*"` |  |
| execution.jsonrpc.websocket.port | int | `8546` |  |
| execution.metrics | object | `{"enabled":true,"host":"0.0.0.0","port":8008,"prometheusRule":{"enabled":true},"serviceMonitor":{"enabled":true}}` | Monitoring Additional settings could be made in non-global section.  |
| execution.metrics.enabled | bool | `true` | Whether to enable metrics collection or not |
| execution.metrics.prometheusRule | object | `{"enabled":true}` | Custom PrometheusRule to be defined ref: https://github.com/coreos/prometheus-operator#customresourcedefinitions  |
| execution.metrics.prometheusRule.enabled | bool | `true` | Create a custom prometheusRule Resource for scraping metrics using PrometheusOperator |
| execution.metrics.serviceMonitor | object | `{"enabled":true}` | Prometheus Service Monitor ref: https://github.com/coreos/prometheus-operator      https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint  |
| execution.metrics.serviceMonitor.enabled | bool | `true` | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator |
| execution.persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"size":"100Gi","storageClassName":""}` | Whether or not to allocate persistent volume disk for the data directory. In case of node failure, the node data directory will still persist.  |
| execution.privateApiAddr | string | `"127.0.0.1:9090"` | Private api network address, for example: 127.0.0.1:9090, empty string means not to start the listener. Do not expose to public network. Serves remote database interface (default: "127.0.0.1:9090")  |
| execution.resources | object | `{}` |  |
| execution.targetPeers | int | `50` |  |
| execution.terminalTotalDifficulty | string | `""` | Manually specify TerminalTotalDifficulty, overriding the bundled setting |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| global.JWTSecret | string | `""` | JSON Web Token (JWT) authentication is used to secure the communication between the beacon node and execution client. You can generate a JWT using a command line tool, for example: openssl rand -hex 32 > token.txt |
| global.affinity | object | `{}` | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity  |
| global.ethsider.bindAddr | int | `3000` |  |
| global.ethsider.enabled | bool | `true` |  |
| global.ethsider.livenessProbe | object | `{"enabled":false,"failureThreshold":3,"httpGet":{"path":"/liveness","port":"sidecar","scheme":"HTTP"},"initialDelaySeconds":10,"periodSeconds":1,"successThreshold":3,"timeoutSeconds":3}` | Configure liveness and readiness probes ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/ NB! readinessProbe and livenessProbe must be disabled before genesis  |
| global.ethsider.pullPolicy | string | `"IfNotPresent"` |  |
| global.ethsider.readinessProbe.enabled | bool | `true` |  |
| global.ethsider.readinessProbe.failureThreshold | int | `3` |  |
| global.ethsider.readinessProbe.httpGet.path | string | `"/readiness"` |  |
| global.ethsider.readinessProbe.httpGet.port | string | `"sidecar"` |  |
| global.ethsider.readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| global.ethsider.readinessProbe.initialDelaySeconds | int | `10` |  |
| global.ethsider.readinessProbe.periodSeconds | int | `1` |  |
| global.ethsider.readinessProbe.successThreshold | int | `3` |  |
| global.ethsider.readinessProbe.timeoutSeconds | int | `3` |  |
| global.ethsider.repository | string | `"nethermindeth/ethsider"` |  |
| global.ethsider.tag | string | `"v1.0.0"` |  |
| global.externalSecrets.data | list | `[]` |  |
| global.externalSecrets.enabled | bool | `false` |  |
| global.externalSecrets.secretStoreRef.kind | string | `"SecretStore"` |  |
| global.externalSecrets.secretStoreRef.name | string | `"secretStoreRef"` |  |
| global.image.beacon.lighthouse.repository | string | `"sigp/lighthouse"` |  |
| global.image.beacon.lighthouse.tag | string | `"v4.5.0"` |  |
| global.image.beacon.lodestar.repository | string | `"chainsafe/lodestar"` |  |
| global.image.beacon.lodestar.tag | string | `"v1.13.0"` |  |
| global.image.beacon.nimbus.repository | string | `"statusim/nimbus-eth2"` |  |
| global.image.beacon.nimbus.tag | string | `"multiarch-v24.1.0"` |  |
| global.image.beacon.prysm.repository | string | `"gcr.io/prylabs-dev/prysm/beacon-chain"` |  |
| global.image.beacon.prysm.tag | string | `"v4.1.1"` |  |
| global.image.beacon.teku.repository | string | `"consensys/teku"` |  |
| global.image.beacon.teku.tag | string | `"23.12.1"` |  |
| global.image.execution.bseu.repository | string | `"hyperledger/besu"` |  |
| global.image.execution.bseu.tag | string | `"23.10.2"` |  |
| global.image.execution.erigon.repository | string | `"thorax/erigon"` |  |
| global.image.execution.erigon.tag | string | `"v2.55.1"` |  |
| global.image.execution.geth.repository | string | `"ethereum/client-go"` |  |
| global.image.execution.geth.tag | string | `"v1.13.8"` |  |
| global.image.execution.nethermind.repository | string | `"nethermind/nethermind"` |  |
| global.image.execution.nethermind.tag | string | `"1.24.0"` |  |
| global.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| global.imagePullSecrets | list | `[]` | Credentials to fetch images from private registry ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/  |
| global.ingress.annotations | object | `{}` |  |
| global.ingress.enabled | bool | `false` |  |
| global.ingress.hosts | list | `[]` | Hostnames. Must be provided if Ingress is enabled.  |
| global.ingress.ingressClassName | string | `"nginx"` |  |
| global.ingress.labels | object | `{}` |  |
| global.ingress.paths | list | `[]` | Paths to use for ingress rules By default, the Service created by this chart is used as the target Service for the Ingress. If not defined the following default object will be used: - path: "/"   port: 8545   pathType: "ImplementationSpecific"   serviceName: "<common.names.fullname>"  |
| global.ingress.routePrefix | string | `"/"` | Route Prefix. Can skip it if any item of path has the path defined. |
| global.ingress.tls | list | `[]` | TLS configuration for Ingress Secret must be manually created in the namespace  |
| global.initImage | object | `{"pullPolicy":"IfNotPresent","repository":"bitnami/kubectl","tag":"1.28"}` | Init image is used to chown data volume, initialise genesis, etc. |
| global.metrics | object | `{"annotations":{},"enabled":true,"prometheusRule":{"additionalLabels":{},"default":true,"namespace":"","rules":[]},"serviceMonitor":{"additionalLabels":{},"honorLabels":false,"interval":"30s","metricRelabelings":[],"namespace":"","relabellings":[],"scrapeTimeout":""}}` | Monitoring |
| global.metrics.prometheusRule | object | `{"additionalLabels":{},"default":true,"namespace":"","rules":[]}` | Custom PrometheusRule to be defined ref: https://github.com/coreos/prometheus-operator#customresourcedefinitions  |
| global.metrics.prometheusRule.additionalLabels | object | `{}` | Additional labels for the prometheusRule |
| global.metrics.prometheusRule.default | bool | `true` | Create a default set of Alerts |
| global.metrics.prometheusRule.namespace | string | `""` | The namespace in which the prometheusRule will be created |
| global.metrics.prometheusRule.rules | list | `[]` | Custom Prometheus rules |
| global.metrics.serviceMonitor | object | `{"additionalLabels":{},"honorLabels":false,"interval":"30s","metricRelabelings":[],"namespace":"","relabellings":[],"scrapeTimeout":""}` | Prometheus Service Monitor ref: https://github.com/coreos/prometheus-operator      https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint  |
| global.metrics.serviceMonitor.additionalLabels | object | `{}` | Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus |
| global.metrics.serviceMonitor.honorLabels | bool | `false` | Specify honorLabels parameter to add the scrape endpoint |
| global.metrics.serviceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped |
| global.metrics.serviceMonitor.metricRelabelings | list | `[]` | Metrics RelabelConfigs to apply to samples before ingestion. |
| global.metrics.serviceMonitor.namespace | string | `""` | The namespace in which the ServiceMonitor will be created |
| global.metrics.serviceMonitor.relabellings | list | `[]` | Metrics RelabelConfigs to apply to samples before scraping. |
| global.metrics.serviceMonitor.scrapeTimeout | string | `""` | The timeout after which the scrape is ended |
| global.network | string | `"mainnet"` | Ethereum network |
| global.nodeSelector | object | `{}` | Node labels for pod assignment ref: https://kubernetes.io/docs/user-guide/node-selection/  |
| global.p2pNodePort | object | `{"annotations":{},"enabled":false,"replicaToNodePort":{},"startAtBeacon":31200,"startAtExecution":31100,"type":"NodePort"}` | When p2pNodePort is enabled, your P2P port will be exposed via service type NodePort. This will generate a service for each replica, with a port binding via NodePort. This is useful if you want to expose and announce your node to the Internet.  |
| global.p2pNodePort.enabled | bool | `false` | Expose P2P port via NodePort |
| global.p2pNodePort.replicaToNodePort | object | See `values.yaml` for example | Overwrite a port for specific replicas |
| global.p2pNodePort.startAtExecution | int | `31100` | The ports allocation will start from this value |
| global.p2pNodePort.type | string | `"NodePort"` | Options: NodePort, LoadBalancer |
| global.podSecurityContext | object | `{"fsGroup":10000,"runAsNonRoot":true,"runAsUser":10000}` | Pod Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/  |
| global.priorityClassName | string | `""` | Used to assign priority to pods ref: https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/  |
| global.rbac | object | `{"create":true}` | RBAC configuration. ref: https://kubernetes.io/docs/reference/access-authn-authz/rbac/  |
| global.replicaCount | int | `1` |  |
| global.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| global.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| global.securityContext.runAsNonRoot | bool | `true` |  |
| global.securityContext.runAsUser | int | `10000` |  |
| global.service.svcHeadless | bool | `true` |  |
| global.service.type | string | `"ClusterIP"` |  |
| global.serviceAccount | object | `{"create":true}` | Service account ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/  |
| global.sessionAffinity.enabled | bool | `false` | Whether to enable session affinity or not |
| global.sessionAffinity.timeoutSeconds | int | `86400` | The session duration in seconds |
| global.sharedPersistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":false,"size":"300Gi","storageClassName":""}` | Whether or not to allocate persistent volume disk for the data directory. In case of node failure, the node data directory will still persist.  |
| global.terminationGracePeriodSeconds | int | `120` | Termination Grace Period ref: https://kubernetes.io/docs/tasks/run-application/force-delete-stateful-set-pod/#delete-pods  |
| global.tolerations | object | `{}` | Tolerations for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/  |
| nameOverride | string | `""` | Provide a name in place of geth for `app:` labels |
| rbac | object | `{"clusterRules":[{"apiGroups":[""],"resources":["nodes"],"verbs":["get","list","watch"]}],"name":"","rules":[{"apiGroups":[""],"resources":["services"],"verbs":["get","list","watch"]}]}` | RBAC configuration. ref: https://kubernetes.io/docs/reference/access-authn-authz/rbac/  |
| rbac.clusterRules | list | `[{"apiGroups":[""],"resources":["nodes"],"verbs":["get","list","watch"]}]` | Required ClusterRole rules |
| rbac.clusterRules[0] | object | `{"apiGroups":[""],"resources":["nodes"],"verbs":["get","list","watch"]}` | Required to obtain the nodes external IP |
| rbac.name | string | `""` | The name of the cluster role to use. If not set and create is true, a name is generated using the fullname template  |
| rbac.rules | list | `[{"apiGroups":[""],"resources":["services"],"verbs":["get","list","watch"]}]` | Required Role rules |
| rbac.rules[0] | object | `{"apiGroups":[""],"resources":["services"],"verbs":["get","list","watch"]}` | Required to get information about the services nodePort.  |
| serviceAccount | object | `{"annotations":{},"name":""}` | Service account ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
