# kong

![Version: 2.26.6](https://img.shields.io/badge/Version-2.26.6-informational?style=flat-square) ![AppVersion: 3.3](https://img.shields.io/badge/AppVersion-3.3-informational?style=flat-square)

The Cloud-Native Ingress and API-management

**Homepage:** <https://konghq.com/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Manjeet-Nethermind | <manjeet@nethermind.io> |  |
| gehlotanish | <anish@nethermind.io> |  |

## Source Code

* <https://github.com/Kong/charts/tree/main/charts/kong>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 11.9.13 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| admin.annotations | object | `{}` |  |
| admin.enabled | bool | `false` |  |
| admin.http.containerPort | int | `8001` |  |
| admin.http.enabled | bool | `false` |  |
| admin.http.parameters | list | `[]` |  |
| admin.http.servicePort | int | `8001` |  |
| admin.ingress.annotations | object | `{}` |  |
| admin.ingress.enabled | bool | `false` |  |
| admin.ingress.hostname | string | `nil` |  |
| admin.ingress.ingressClassName | string | `nil` |  |
| admin.ingress.path | string | `"/"` |  |
| admin.ingress.pathType | string | `"ImplementationSpecific"` |  |
| admin.labels | object | `{}` |  |
| admin.loadBalancerClass | string | `nil` |  |
| admin.tls.client.caBundle | string | `""` |  |
| admin.tls.client.secretName | string | `""` |  |
| admin.tls.containerPort | int | `8444` |  |
| admin.tls.enabled | bool | `true` |  |
| admin.tls.parameters[0] | string | `"http2"` |  |
| admin.tls.servicePort | int | `8444` |  |
| admin.type | string | `"NodePort"` |  |
| autoscaling.behavior | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.metrics[0].resource.name | string | `"cpu"` |  |
| autoscaling.metrics[0].resource.target.averageUtilization | int | `80` |  |
| autoscaling.metrics[0].resource.target.type | string | `"Utilization"` |  |
| autoscaling.metrics[0].type | string | `"Resource"` |  |
| autoscaling.minReplicas | int | `2` |  |
| autoscaling.targetCPUUtilizationPercentage | string | `nil` |  |
| certificates | object | `{"admin":{"clusterIssuer":"","commonName":"kong.example","dnsNames":[],"enabled":true,"issuer":""},"cluster":{"clusterIssuer":"","commonName":"kong_clustering","dnsNames":[],"enabled":true,"issuer":""},"clusterIssuer":"","enabled":false,"issuer":"","portal":{"clusterIssuer":"","commonName":"developer.example","dnsNames":[],"enabled":true,"issuer":""},"proxy":{"clusterIssuer":"","commonName":"app.example","dnsNames":[],"enabled":true,"issuer":""}}` | --------------------------------------------------------------------------- |
| cluster.annotations | object | `{}` |  |
| cluster.enabled | bool | `false` |  |
| cluster.ingress.annotations | object | `{}` |  |
| cluster.ingress.enabled | bool | `false` |  |
| cluster.ingress.hostname | string | `nil` |  |
| cluster.ingress.ingressClassName | string | `nil` |  |
| cluster.ingress.path | string | `"/"` |  |
| cluster.ingress.pathType | string | `"ImplementationSpecific"` |  |
| cluster.labels | object | `{}` |  |
| cluster.loadBalancerClass | string | `nil` |  |
| cluster.tls.containerPort | int | `8005` |  |
| cluster.tls.enabled | bool | `false` |  |
| cluster.tls.parameters | list | `[]` |  |
| cluster.tls.servicePort | int | `8005` |  |
| cluster.type | string | `"ClusterIP"` |  |
| clusterCaSecretName | string | `""` |  |
| clustertelemetry.annotations | object | `{}` |  |
| clustertelemetry.enabled | bool | `false` |  |
| clustertelemetry.ingress.annotations | object | `{}` |  |
| clustertelemetry.ingress.enabled | bool | `false` |  |
| clustertelemetry.ingress.hostname | string | `nil` |  |
| clustertelemetry.ingress.ingressClassName | string | `nil` |  |
| clustertelemetry.ingress.path | string | `"/"` |  |
| clustertelemetry.ingress.pathType | string | `"ImplementationSpecific"` |  |
| clustertelemetry.labels | object | `{}` |  |
| clustertelemetry.loadBalancerClass | string | `nil` |  |
| clustertelemetry.tls.containerPort | int | `8006` |  |
| clustertelemetry.tls.enabled | bool | `false` |  |
| clustertelemetry.tls.parameters | list | `[]` |  |
| clustertelemetry.tls.servicePort | int | `8006` |  |
| clustertelemetry.type | string | `"ClusterIP"` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| dblessConfig.config | string | `""` |  |
| dblessConfig.configMap | string | `""` |  |
| dblessConfig.secret | string | `""` |  |
| deployment.daemonset | bool | `false` |  |
| deployment.hostNetwork | bool | `false` |  |
| deployment.kong.enabled | bool | `true` |  |
| deployment.prefixDir.sizeLimit | string | `"256Mi"` |  |
| deployment.serviceAccount.automountServiceAccountToken | bool | `false` |  |
| deployment.serviceAccount.create | bool | `true` |  |
| deployment.test.enabled | bool | `false` |  |
| deployment.tmpDir.sizeLimit | string | `"1Gi"` |  |
| deploymentAnnotations | object | `{}` |  |
| enterprise | object | `{"enabled":false,"portal":{"enabled":false},"rbac":{"admin_gui_auth":"basic-auth","admin_gui_auth_conf_secret":"CHANGEME-admin-gui-auth-conf-secret","enabled":false,"session_conf_secret":"kong-session-config"},"smtp":{"admin_emails_from":"none@example.com","admin_emails_reply_to":"none@example.com","auth":{"smtp_password_secret":"CHANGEME-smtp-password","smtp_username":""},"enabled":false,"portal_emails_from":"none@example.com","portal_emails_reply_to":"none@example.com","smtp_admin_emails":"none@example.com","smtp_auth_type":"","smtp_host":"smtp.example.com","smtp_port":587,"smtp_ssl":"nil","smtp_starttls":true},"vitals":{"enabled":true}}` | --------------------------------------------------------------------------- Toggle Kong Enterprise features on or off RBAC and SMTP configuration have additional options that must all be set together Other settings should be added to the "env" settings below |
| env | object | `{"admin_access_log":"/dev/stdout","admin_error_log":"/dev/stderr","admin_gui_access_log":"/dev/stdout","admin_gui_error_log":"/dev/stderr","database":"off","nginx_worker_processes":"2","portal_api_access_log":"/dev/stdout","portal_api_error_log":"/dev/stderr","prefix":"/kong_prefix/","proxy_access_log":"/dev/stdout","proxy_error_log":"/dev/stderr","router_flavor":"traditional"}` | --------------------------------------------------------------------------- Specify Kong configuration This chart takes all entries defined under `.env` and transforms them into into `KONG_*` environment variables for Kong containers. Their names here should match the names used in https://github.com/Kong/kong/blob/master/kong.conf.default See https://docs.konghq.com/latest/configuration also for additional details Values here take precedence over values from other sections of values.yaml, e.g. setting pg_user here will override the value normally set when postgresql.enabled is set below. In general, you should not set values here if they are set elsewhere. |
| extraConfigMaps | list | `[]` |  |
| extraLabels | object | `{}` |  |
| extraObjects | list | `[]` |  |
| extraSecrets | list | `[]` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"kong"` |  |
| image.tag | string | `"3.3"` |  |
| ingressController | object | `{"adminApi":{"tls":{"client":{"caSecretName":"","certProvided":false,"enabled":false,"secretName":""}}},"admissionWebhook":{"certificate":{"provided":false},"enabled":true,"failurePolicy":"Ignore","namespaceSelector":{},"port":8080,"service":{"labels":{}}},"args":[],"enabled":true,"env":{"kong_admin_tls_skip_verify":true},"gatewayDiscovery":{"adminApiService":{"name":"","namespace":""},"enabled":false,"generateAdminApiService":false},"image":{"effectiveSemver":null,"repository":"kong/kubernetes-ingress-controller","tag":"2.11"},"ingressClass":"kong","ingressClassAnnotations":{},"konnect":{"apiHostname":"us.kic.api.konghq.com","enabled":false,"license":{"enabled":false},"runtimeGroupID":"","tlsClientCertSecretName":"konnect-client-tls"},"livenessProbe":{"failureThreshold":3,"httpGet":{"path":"/healthz","port":10254,"scheme":"HTTP"},"initialDelaySeconds":5,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5},"rbac":{"create":true},"readinessProbe":{"failureThreshold":3,"httpGet":{"path":"/readyz","port":10254,"scheme":"HTTP"},"initialDelaySeconds":5,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":5},"resources":{},"watchNamespaces":[]}` | --------------------------------------------------------------------------- Kong Ingress Controller's primary purpose is to satisfy Ingress resources created in k8s.  It uses CRDs for more fine grained control over routing and for Kong specific configuration. |
| lifecycle.preStop.exec.command[0] | string | `"kong"` |  |
| lifecycle.preStop.exec.command[1] | string | `"quit"` |  |
| lifecycle.preStop.exec.command[2] | string | `"--wait=15"` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.httpGet.path | string | `"/status"` |  |
| livenessProbe.httpGet.port | string | `"status"` |  |
| livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.initialDelaySeconds | int | `5` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| manager.annotations | object | `{}` |  |
| manager.enabled | bool | `true` |  |
| manager.http.containerPort | int | `8002` |  |
| manager.http.enabled | bool | `true` |  |
| manager.http.parameters | list | `[]` |  |
| manager.http.servicePort | int | `8002` |  |
| manager.ingress.annotations | object | `{}` |  |
| manager.ingress.enabled | bool | `false` |  |
| manager.ingress.hostname | string | `nil` |  |
| manager.ingress.ingressClassName | string | `nil` |  |
| manager.ingress.path | string | `"/"` |  |
| manager.ingress.pathType | string | `"ImplementationSpecific"` |  |
| manager.labels | object | `{}` |  |
| manager.loadBalancerClass | string | `nil` |  |
| manager.tls.containerPort | int | `8445` |  |
| manager.tls.enabled | bool | `true` |  |
| manager.tls.parameters[0] | string | `"http2"` |  |
| manager.tls.servicePort | int | `8445` |  |
| manager.type | string | `"NodePort"` |  |
| migrations.annotations."sidecar.istio.io/inject" | bool | `false` |  |
| migrations.backoffLimit | string | `nil` |  |
| migrations.jobAnnotations | object | `{}` |  |
| migrations.postUpgrade | bool | `true` |  |
| migrations.preUpgrade | bool | `true` |  |
| migrations.resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| plugins | object | `{}` |  |
| podAnnotations."kuma.io/gateway" | string | `"enabled"` |  |
| podAnnotations."traffic.sidecar.istio.io/includeInboundPorts" | string | `""` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podLabels | object | `{}` |  |
| podSecurityPolicy.annotations | object | `{}` |  |
| podSecurityPolicy.enabled | bool | `false` |  |
| podSecurityPolicy.labels | object | `{}` |  |
| podSecurityPolicy.spec.allowPrivilegeEscalation | bool | `false` |  |
| podSecurityPolicy.spec.fsGroup.rule | string | `"RunAsAny"` |  |
| podSecurityPolicy.spec.hostIPC | bool | `false` |  |
| podSecurityPolicy.spec.hostNetwork | bool | `false` |  |
| podSecurityPolicy.spec.hostPID | bool | `false` |  |
| podSecurityPolicy.spec.privileged | bool | `false` |  |
| podSecurityPolicy.spec.readOnlyRootFilesystem | bool | `true` |  |
| podSecurityPolicy.spec.runAsGroup.rule | string | `"RunAsAny"` |  |
| podSecurityPolicy.spec.runAsUser.rule | string | `"RunAsAny"` |  |
| podSecurityPolicy.spec.seLinux.rule | string | `"RunAsAny"` |  |
| podSecurityPolicy.spec.supplementalGroups.rule | string | `"RunAsAny"` |  |
| podSecurityPolicy.spec.volumes[0] | string | `"configMap"` |  |
| podSecurityPolicy.spec.volumes[1] | string | `"secret"` |  |
| podSecurityPolicy.spec.volumes[2] | string | `"emptyDir"` |  |
| podSecurityPolicy.spec.volumes[3] | string | `"projected"` |  |
| portal.annotations | object | `{}` |  |
| portal.enabled | bool | `true` |  |
| portal.http.containerPort | int | `8003` |  |
| portal.http.enabled | bool | `true` |  |
| portal.http.parameters | list | `[]` |  |
| portal.http.servicePort | int | `8003` |  |
| portal.ingress.annotations | object | `{}` |  |
| portal.ingress.enabled | bool | `false` |  |
| portal.ingress.hostname | string | `nil` |  |
| portal.ingress.ingressClassName | string | `nil` |  |
| portal.ingress.path | string | `"/"` |  |
| portal.ingress.pathType | string | `"ImplementationSpecific"` |  |
| portal.labels | object | `{}` |  |
| portal.loadBalancerClass | string | `nil` |  |
| portal.tls.containerPort | int | `8446` |  |
| portal.tls.enabled | bool | `true` |  |
| portal.tls.parameters[0] | string | `"http2"` |  |
| portal.tls.servicePort | int | `8446` |  |
| portal.type | string | `"NodePort"` |  |
| portalapi.annotations | object | `{}` |  |
| portalapi.enabled | bool | `true` |  |
| portalapi.http.containerPort | int | `8004` |  |
| portalapi.http.enabled | bool | `true` |  |
| portalapi.http.parameters | list | `[]` |  |
| portalapi.http.servicePort | int | `8004` |  |
| portalapi.ingress.annotations | object | `{}` |  |
| portalapi.ingress.enabled | bool | `false` |  |
| portalapi.ingress.hostname | string | `nil` |  |
| portalapi.ingress.ingressClassName | string | `nil` |  |
| portalapi.ingress.path | string | `"/"` |  |
| portalapi.ingress.pathType | string | `"ImplementationSpecific"` |  |
| portalapi.labels | object | `{}` |  |
| portalapi.loadBalancerClass | string | `nil` |  |
| portalapi.tls.containerPort | int | `8447` |  |
| portalapi.tls.enabled | bool | `true` |  |
| portalapi.tls.parameters[0] | string | `"http2"` |  |
| portalapi.tls.servicePort | int | `8447` |  |
| portalapi.type | string | `"NodePort"` |  |
| postgresql | object | `{"auth":{"database":"kong","username":"kong"},"enabled":false,"image":{"tag":"13.11.0-debian-11-r20"},"service":{"ports":{"postgresql":"5432"}}}` | --------------------------------------------------------------------------- Kong can run without a database or use either Postgres or Cassandra as a backend datatstore for it's configuration. By default, this chart installs Kong without a database. If you would like to use a database, there are two options: - (recommended) Deploy and maintain a database and pass the connection   details to Kong via the `env` section. - You can use the below `postgresql` sub-chart to deploy a database   along-with Kong as part of a single Helm release. Running a database   independently is recommended for production, but the built-in Postgres is   useful for quickly creating test instances. PostgreSQL chart documentation: https://github.com/bitnami/charts/blob/master/bitnami/postgresql/README.md  WARNING: by default, the Postgres chart generates a random password each time it upgrades, which breaks access to existing volumes. You should set a password explicitly: https://github.com/Kong/charts/blob/main/charts/kong/FAQs.md#kong-fails-to-start-after-helm-upgrade-when-postgres-is-used-what-do-i-do |
| priorityClassName | string | `""` |  |
| proxy.annotations | object | `{}` |  |
| proxy.enabled | bool | `true` |  |
| proxy.http.containerPort | int | `8000` |  |
| proxy.http.enabled | bool | `true` |  |
| proxy.http.parameters | list | `[]` |  |
| proxy.http.servicePort | int | `80` |  |
| proxy.ingress.annotations | object | `{}` |  |
| proxy.ingress.enabled | bool | `false` |  |
| proxy.ingress.hostname | string | `nil` |  |
| proxy.ingress.hosts | list | `[]` |  |
| proxy.ingress.ingressClassName | string | `nil` |  |
| proxy.ingress.labels | object | `{}` |  |
| proxy.ingress.path | string | `"/"` |  |
| proxy.ingress.pathType | string | `"ImplementationSpecific"` |  |
| proxy.labels.enable-metrics | string | `"true"` |  |
| proxy.loadBalancerClass | string | `nil` |  |
| proxy.nameOverride | string | `""` |  |
| proxy.stream | list | `[]` |  |
| proxy.tls.containerPort | int | `8443` |  |
| proxy.tls.enabled | bool | `true` |  |
| proxy.tls.parameters[0] | string | `"http2"` |  |
| proxy.tls.servicePort | int | `443` |  |
| proxy.type | string | `"LoadBalancer"` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/status/ready"` |  |
| readinessProbe.httpGet.port | string | `"status"` |  |
| readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| secretVolumes | list | `[]` |  |
| securityContext | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| status.enabled | bool | `true` |  |
| status.http.containerPort | int | `8100` |  |
| status.http.enabled | bool | `true` |  |
| status.http.parameters | list | `[]` |  |
| status.tls.containerPort | int | `8543` |  |
| status.tls.enabled | bool | `false` |  |
| status.tls.parameters | list | `[]` |  |
| terminationGracePeriodSeconds | int | `30` |  |
| tolerations | list | `[]` |  |
| udpProxy.annotations | object | `{}` |  |
| udpProxy.enabled | bool | `false` |  |
| udpProxy.labels | object | `{}` |  |
| udpProxy.loadBalancerClass | string | `nil` |  |
| udpProxy.stream | list | `[]` |  |
| udpProxy.type | string | `"LoadBalancer"` |  |
| updateStrategy | object | `{}` |  |
| waitImage | object | `{"enabled":true,"pullPolicy":"IfNotPresent"}` | --------------------------------------------------------------------------- |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
