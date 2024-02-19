# loki

![Version: 2.11.2](https://img.shields.io/badge/Version-2.11.2-informational?style=flat-square) ![AppVersion: v2.5.0](https://img.shields.io/badge/AppVersion-v2.5.0-informational?style=flat-square)

Loki: like Prometheus, but for logs.

**Homepage:** <https://grafana.com/loki>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Manjeet-Nethermind | <manjeet@nethermind.io> |  |
| gehlotanish | <anish@nethermind.io> |  |

## Source Code

* <https://github.com/grafana/loki>

## Requirements

Kubernetes: `^1.10.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].key | string | `"node_pool"` |  |
| affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].operator | string | `"In"` |  |
| affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].values[0] | string | `"monitoring"` |  |
| alerting_groups | list | `[]` |  |
| annotations | object | `{}` |  |
| client | object | `{}` |  |
| config.auth_enabled | bool | `false` |  |
| config.chunk_store_config.max_look_back_period | string | `"0s"` |  |
| config.compactor.shared_store | string | `"gcs"` |  |
| config.compactor.working_directory | string | `"/data/loki/boltdb-shipper-compactor"` |  |
| config.ingester.chunk_block_size | int | `262144` |  |
| config.ingester.chunk_idle_period | string | `"3m"` |  |
| config.ingester.chunk_retain_period | string | `"1m"` |  |
| config.ingester.lifecycler.ring.kvstore.store | string | `"inmemory"` |  |
| config.ingester.lifecycler.ring.replication_factor | int | `1` |  |
| config.ingester.max_transfer_retries | int | `0` |  |
| config.ingester.wal.dir | string | `"/data/loki/wal"` |  |
| config.limits_config.enforce_metric_name | bool | `false` |  |
| config.limits_config.max_entries_limit_per_query | int | `5000` |  |
| config.limits_config.reject_old_samples | bool | `true` |  |
| config.limits_config.reject_old_samples_max_age | string | `"168h"` |  |
| config.schema_config.configs[0].from | string | `"2020-10-24"` |  |
| config.schema_config.configs[0].index.period | string | `"24h"` |  |
| config.schema_config.configs[0].index.prefix | string | `"index_"` |  |
| config.schema_config.configs[0].object_store | string | `"gcs"` |  |
| config.schema_config.configs[0].schema | string | `"v11"` |  |
| config.schema_config.configs[0].store | string | `"boltdb-shipper"` |  |
| config.server.http_listen_port | int | `3100` |  |
| config.storage_config.boltdb_shipper.active_index_directory | string | `"/data/loki/boltdb-shipper-active"` |  |
| config.storage_config.boltdb_shipper.cache_location | string | `"/data/loki/boltdb-shipper-cache"` |  |
| config.storage_config.boltdb_shipper.cache_ttl | string | `"24h"` |  |
| config.storage_config.boltdb_shipper.shared_store | string | `"gcs"` |  |
| config.storage_config.gcs.bucket_name | string | `"loki-logs-juno-dev"` |  |
| config.table_manager.retention_deletes_enabled | bool | `false` |  |
| config.table_manager.retention_period | string | `"0s"` |  |
| env | list | `[]` |  |
| extraArgs | object | `{}` |  |
| extraContainers | list | `[]` |  |
| extraPorts | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"grafana/loki"` |  |
| image.tag | string | `"2.5.0"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/ready"` |  |
| livenessProbe.httpGet.port | string | `"http-metrics"` |  |
| livenessProbe.initialDelaySeconds | int | `45` |  |
| networkPolicy.enabled | bool | `false` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `false` |  |
| persistence.size | string | `"10Gi"` |  |
| podAnnotations."prometheus.io/port" | string | `"http-metrics"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| podDisruptionBudget | object | `{}` |  |
| podLabels | object | `{}` |  |
| podManagementPolicy | string | `"OrderedReady"` |  |
| rbac.create | bool | `true` |  |
| rbac.pspEnabled | bool | `true` |  |
| readinessProbe.httpGet.path | string | `"/ready"` |  |
| readinessProbe.httpGet.port | string | `"http-metrics"` |  |
| readinessProbe.initialDelaySeconds | int | `45` |  |
| replicas | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.fsGroup | int | `10001` |  |
| securityContext.runAsGroup | int | `10001` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `10001` |  |
| service.annotations | object | `{}` |  |
| service.labels | object | `{}` |  |
| service.nodePort | string | `nil` |  |
| service.port | int | `3100` |  |
| service.targetPort | string | `"http-metrics"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations."iam.gke.io/gcp-service-account" | string | `"monitoring-sa@juno-dev-nth.iam.gserviceaccount.com"` |  |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `nil` |  |
| serviceMonitor.additionalLabels | object | `{}` |  |
| serviceMonitor.annotations | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `""` |  |
| serviceMonitor.prometheusRule.additionalLabels | object | `{}` |  |
| serviceMonitor.prometheusRule.enabled | bool | `false` |  |
| serviceMonitor.prometheusRule.rules | list | `[]` |  |
| service_lb.annotations."cloud.google.com/load-balancer-type" | string | `"internal"` |  |
| service_lb.annotations."external-dns.alpha.kubernetes.io/hostname" | string | `"loki.juno.dev"` |  |
| service_lb.annotations."networking.gke.io/internal-load-balancer-allow-global-access" | string | `"true"` |  |
| service_lb.enable | bool | `true` |  |
| service_lb.labels | object | `{}` |  |
| service_lb.nodePort | string | `nil` |  |
| service_lb.port | int | `80` |  |
| service_lb.targetPort | string | `"http-metrics"` |  |
| service_lb.type | string | `"LoadBalancer"` |  |
| terminationGracePeriodSeconds | int | `4800` |  |
| tolerations[0].effect | string | `"PreferNoSchedule"` |  |
| tolerations[0].key | string | `"monitoring"` |  |
| tolerations[0].operator | string | `"Equal"` |  |
| tolerations[0].value | bool | `true` |  |
| tracing.jaegerAgentHost | string | `nil` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |
| useExistingAlertingGroup.configmapName | string | `""` |  |
| useExistingAlertingGroup.enabled | bool | `false` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
