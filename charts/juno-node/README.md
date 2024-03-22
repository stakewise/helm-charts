# juno-chart

![Version: 0.1.4](https://img.shields.io/badge/Version-0.1.4-informational?style=flat-square) ![AppVersion: 1](https://img.shields.io/badge/AppVersion-1-informational?style=flat-square)

A Helm chart for deploying Juno service

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Manjeet-Nethermind | <manjeet@nethermind.io> |  |
| gehlotanish | <anish@nethermind.io> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args.--db-path | string | `"/var/lib/juno"` |  |
| args.--http | string | `"true"` |  |
| args.--http-host | string | `"0.0.0.0"` |  |
| args.--http-port | string | `"6060"` |  |
| args.--metrics | string | `"true"` |  |
| args.--metrics-host | string | `"0.0.0.0"` |  |
| args.--metrics-port | string | `"9090"` |  |
| args.--network | string | `"goerli"` |  |
| args.--pending-poll-interval | string | `"2s"` |  |
| args.--ws | string | `"true"` |  |
| args.--ws-host | string | `"0.0.0.0"` |  |
| args.--ws-port | string | `"6061"` |  |
| batchjob.enabled | bool | `false` |  |
| batchjob.schedule | string | `"* */1 * * *"` |  |
| deployment.healthCheck.enabled | bool | `false` |  |
| deployment.healthCheck.livenessProbe.failureThreshold | int | `6` |  |
| deployment.healthCheck.livenessProbe.initialDelaySeconds | int | `9600` |  |
| deployment.healthCheck.livenessProbe.periodSeconds | int | `600` |  |
| deployment.healthCheck.readinessProbe.failureThreshold | int | `6` |  |
| deployment.healthCheck.readinessProbe.initialDelaySeconds | int | `9600` |  |
| deployment.healthCheck.readinessProbe.periodSeconds | int | `600` |  |
| deployment.imagename | string | `"nethermind/juno"` |  |
| deployment.imagetag | string | `"v0.6.2"` |  |
| deployment.namespace | string | `"test"` |  |
| deployment.port[0] | int | `6060` |  |
| deployment.port[1] | int | `6061` |  |
| deployment.projectName | string | `"goerli-test"` |  |
| deployment.replicas | int | `1` |  |
| deployment.resources.limits.cpu | string | `"4"` |  |
| deployment.resources.limits.memory | string | `"14Gi"` |  |
| deployment.resources.requests.cpu | string | `"2"` |  |
| deployment.resources.requests.memory | string | `"8Gi"` |  |
| deployment.snapshotUrl | string | `""` |  |
| env.data[0].name | string | `"NETWORK"` |  |
| env.data[0].value | string | `"juno"` |  |
| env.enabled | bool | `false` |  |
| hpa.cpuUtilization | int | `80` |  |
| hpa.enabled | bool | `false` |  |
| hpa.maxReplicas | int | `2` |  |
| hpa.minReplicas | int | `1` |  |
| nodeSelector.enabled | bool | `false` |  |
| nodeSelector.label.network | string | `"juno"` |  |
| pgo.config.BUCKET | string | `"gs://juno-prod-pgo-bucket"` |  |
| pgo.config.DURATION | string | `"30"` |  |
| pgo.config.ENV | string | `"juno-integration"` |  |
| pgo.config.ITERATION | string | `"10"` |  |
| pgo.config.URL | string | `"http://localhost:6062/debug/pprof/profile"` |  |
| pgo.enabled | bool | `false` |  |
| pgo.image | string | `"gcr.io/juno-dev-nth/node-pgo-monitor:4.0"` |  |
| pgo.port | int | `3000` |  |
| pgo.resources.limits.cpu | string | `"2"` |  |
| pgo.resources.limits.memory | string | `"4Gi"` |  |
| pgo.resources.requests.cpu | string | `"1"` |  |
| pgo.resources.requests.memory | string | `"2Gi"` |  |
| pvc.datasource | string | `""` |  |
| pvc.enabled | bool | `true` |  |
| pvc.mount[0].mountPath | string | `"/var/lib/juno"` |  |
| pvc.mount[0].pvName | string | `"pv"` |  |
| pvc.mount[0].storageSize | string | `"250Gi"` |  |
| pvc.storageClassName | string | `"standard"` |  |
| serviceAccount.enabled | bool | `false` |  |
| serviceAccount.gcpServiceAccount | string | `"monitoring-sa-euw1@juno-prod-nth.iam.gserviceaccount.com"` |  |
| serviceAccount.name | string | `"juno-pgo"` |  |
| svc.globalStaticInternalIpName | string | `""` |  |
| svc.globalStaticIpName | string | `""` |  |
| svc.ingress.enabled | bool | `true` |  |
| svc.ingress.extraHost.enabled | bool | `false` |  |
| svc.ingress.extraHost.hosts[0] | string | `""` |  |
| svc.ingress.host | string | `"test.juno.rpc.nethermind.dev"` |  |
| svc.ingress.internal | bool | `false` |  |
| svc.ingress.rules[0].host | string | `"test.juno.rpc.nethermind.dev"` |  |
| svc.ingress.rules[0].http | string | `nil` |  |
| svc.ingress.rules[0].paths[0].backend | string | `nil` |  |
| svc.ingress.rules[0].paths[0].path | string | `"/*"` |  |
| svc.ingress.rules[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| svc.ingress.rules[0].paths[0].service.name | string | `"goerli-test"` |  |
| svc.ingress.rules[0].paths[0].service.port.number | int | `6060` |  |
| svc.ingress.rules[0].paths[1].backend | string | `nil` |  |
| svc.ingress.rules[0].paths[1].path | string | `"/ws"` |  |
| svc.ingress.rules[0].paths[1].pathType | string | `"ImplementationSpecific"` |  |
| svc.ingress.rules[0].paths[1].service.name | string | `"goerli-test-wss"` |  |
| svc.ingress.rules[0].paths[1].service.port.number | int | `6061` |  |
| svc.rpc.backendConfig.connectionDraining.drainingTimeoutSec | int | `300` |  |
| svc.rpc.backendConfig.customResponseHeaders.headers[0] | string | `"X-Frame-Options: SAMEORIGIN"` |  |
| svc.rpc.backendConfig.customResponseHeaders.headers[1] | string | `"X-Content-Type-Options: nosniff"` |  |
| svc.rpc.backendConfig.customResponseHeaders.headers[2] | string | `"X-XSS-Protection: 1; mode=block"` |  |
| svc.rpc.backendConfig.customResponseHeaders.headers[3] | string | `"Referrer-Policy: no-referrer-when-downgrade"` |  |
| svc.rpc.backendConfig.customResponseHeaders.headers[4] | string | `"Strict-Transport-Security: max-age=63072000; includeSubDomains; preload"` |  |
| svc.rpc.backendConfig.healthCheck.checkIntervalSec | int | `15` |  |
| svc.rpc.backendConfig.healthCheck.healthyThreshold | int | `1` |  |
| svc.rpc.backendConfig.healthCheck.port | int | `6060` |  |
| svc.rpc.backendConfig.healthCheck.requestPath | string | `"/"` |  |
| svc.rpc.backendConfig.healthCheck.timeoutSec | int | `15` |  |
| svc.rpc.backendConfig.healthCheck.type | string | `"HTTP"` |  |
| svc.rpc.backendConfig.healthCheck.unhealthyThreshold | int | `2` |  |
| svc.rpc.backendConfig.sessionAffinity.affinityType | string | `"GENERATED_COOKIE"` |  |
| svc.rpc.backendConfig.timeoutSec | int | `400` |  |
| svc.rpc.clustertype | string | `"ClusterIP"` |  |
| svc.rpc.internalBackendConfig.connectionDraining.drainingTimeoutSec | int | `300` |  |
| svc.rpc.internalBackendConfig.healthCheck.checkIntervalSec | int | `15` |  |
| svc.rpc.internalBackendConfig.healthCheck.healthyThreshold | int | `1` |  |
| svc.rpc.internalBackendConfig.healthCheck.port | int | `6060` |  |
| svc.rpc.internalBackendConfig.healthCheck.requestPath | string | `"/"` |  |
| svc.rpc.internalBackendConfig.healthCheck.timeoutSec | int | `15` |  |
| svc.rpc.internalBackendConfig.healthCheck.type | string | `"HTTP"` |  |
| svc.rpc.internalBackendConfig.healthCheck.unhealthyThreshold | int | `2` |  |
| svc.rpc.internalBackendConfig.sessionAffinity.affinityType | string | `"GENERATED_COOKIE"` |  |
| svc.rpc.internalBackendConfig.timeoutSec | int | `400` |  |
| svc.rpc.port | string | `"6060"` |  |
| svc.wss.backendConfig.connectionDraining.drainingTimeoutSec | int | `300` |  |
| svc.wss.backendConfig.healthCheck.checkIntervalSec | int | `15` |  |
| svc.wss.backendConfig.healthCheck.healthyThreshold | int | `1` |  |
| svc.wss.backendConfig.healthCheck.port | int | `6060` |  |
| svc.wss.backendConfig.healthCheck.timeoutSec | int | `15` |  |
| svc.wss.backendConfig.healthCheck.type | string | `"HTTP"` |  |
| svc.wss.backendConfig.healthCheck.unhealthyThreshold | int | `2` |  |
| svc.wss.backendConfig.sessionAffinity.affinityType | string | `"GENERATED_COOKIE"` |  |
| svc.wss.backendConfig.timeoutSec | int | `400` |  |
| svc.wss.clustertype | string | `"ClusterIP"` |  |
| svc.wss.internalBackendConfig.connectionDraining.drainingTimeoutSec | int | `300` |  |
| svc.wss.internalBackendConfig.healthCheck.checkIntervalSec | int | `15` |  |
| svc.wss.internalBackendConfig.healthCheck.healthyThreshold | int | `1` |  |
| svc.wss.internalBackendConfig.healthCheck.port | int | `6060` |  |
| svc.wss.internalBackendConfig.healthCheck.requestPath | string | `"/"` |  |
| svc.wss.internalBackendConfig.healthCheck.timeoutSec | int | `15` |  |
| svc.wss.internalBackendConfig.healthCheck.type | string | `"HTTP"` |  |
| svc.wss.internalBackendConfig.healthCheck.unhealthyThreshold | int | `2` |  |
| svc.wss.internalBackendConfig.sessionAffinity.affinityType | string | `"GENERATED_COOKIE"` |  |
| svc.wss.internalBackendConfig.timeoutSec | int | `400` |  |
| svc.wss.port | string | `"6061"` |  |
| taintsToleration.enabled | bool | `false` |  |
| taintsToleration.tolerations.network | string | `"juno"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
