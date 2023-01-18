Charon
===========

Charon is an open-source Ethereum Distributed validator client written in golang.

# Charon Helm Chart

* Installs Charon distributed validator client node [Charon](https://github.com/ObolNetwork/charon)

## Get Repo Info

```bash
$ helm repo add stakewise https://charts.stakewise.io
$ helm install charon stakewise/charon
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Prerequisites
The charon cluster keys must be generated beforehand and populated to your Kubernetes cluster as secrets in the same namespace where the chart will get deployed.

These are the secrets that should exist for a node name `node0`:
`node0-charon-enr-private-key`
`node0-cluster-lock`
`node0-validators`

## Installing the Chart

To install the chart with the release name `node0`:

```console
helm install node0 obol/charon --set charon.config.beaconNodeEndpoints=<BEACON_NODES_ENDPOINTS>
```

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Configuration

The following table lists the configurable parameters of the Charon chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `global.imagePullSecrets` | `Secret name to pull private images.` | `[]` |
| `global.serviceAccount.create` | `Create charon service account.` | `true` |
| `global.serviceAccount.annotations` | `Charon service account annotations.` | `{}` |
| `global.serviceAccount.name` | `Charon service account name.` | `""` |
| `global.livenessProbe.enabled` | `Enable liveness probe.` | `true` |
| `global.readinessProbe.enabled` | `Enable readiness probe.` | `true` |
| `image.repository` | `Charon image repository.` | `"ghcr.io/obolnetwork/charon"` |
| `image.pullPolicy` | `Charon image pull policy.` | `"IfNotPresent"` |
| `image.tag` | `Charon image version.` | `"v0.11.0"` |
| `imagePullSecrets` | `Charon image pull secret.` | `[]` |
| `nameOverride` | `Chart name override.`  | `""` |
| `fullnameOverride` | `Chart full name override.` | `""` |
| `podAnnotations` | `Pod annotations.` | `{}` |
| `podSecurityContext.fsGroup` | `Pod security context FsGroup.` | `1000` |
| `podSecurityContext.runAsUser` | `Pod security context runAsUser.` | `1000` |
| `securityContext` | `Deployment securityContext.` | `null` |
| `resources` | `CPU/Memory resource requests/limits` | `{}` |
| `nodeSelector` | `Kubernetes node selector.` | `{}` |
| `tolerations` | `Kubernetes tolerations.` | `{}` |
| `affinity` | `Kubernetes pod affinity.` | `{}` |
| `sessionAffinity.enabled` | `Enable aession afinity.` | `false` |
| `sessionAffinity.timeoutSeconds` | `Set session affinity timeout in seconds.` | `86400` |
| `priorityClassName` | `Set deployment priority class name.` | `""` |
| `service.svcHeadless` | `Run charon service as headless.` | `false` |
| `service.type` | `Charon service type.` | `"ClusterIP"` |
| `service.ports.validatorApi.name` | `Charon validator API port name.` | `"validator-api"` |
| `service.ports.validatorApi.port` | `Charon validator API port.` | `3600` |
| `service.ports.validatorApi.protocol` | `Charon validator API port protocol.` | `"TCP"` |
| `service.ports.validatorApi.targetPort` | `Charon validator API target port.` | `3600` |
| `service.ports.p2pTcp.name` | `Charon p2p tcp port name.` | `"p2p-tcp"` |
| `service.ports.p2pTcp.port` | `Charon p2p tcp port.` | `3610` |
| `service.ports.p2pTcp.protocol` | `Charon p2p tcp protocol port.` | `"TCP"` |
| `service.ports.p2pTcp.targetPort` | `Charon p2p tcp target port.` | `3610` |
| `service.ports.monitoring.name` | `Charon monitoring port name.` | `"monitoring"` |
| `service.ports.monitoring.port` | `Charon monitoring port.` | `3620` |
| `service.ports.monitoring.protocol` | `Charon monitoring port protocol.` | `"TCP"` |
| `service.ports.monitoring.targetPort` | `Charon monitoring target port.` | `3620` |
| `service.ports.p2pUdp.name` | `Charon p2p udp port name.` | `"p2p-udp"` |
| `service.ports.p2pUdp.port` | `Charon p2p udp port.` | `3630` |
| `service.ports.p2pUdp.protocol` | `Charon p2p udp port protocol.` | `"UDP"` |
| `service.ports.p2pUdp.targetPort` | `Charon p2p udp target port.` | `3630` |
| `livenessProbe.httpGet.path` | `Charon livenessProbe http path.` | `"/metrics"` |
| `livenessProbe.httpGet.port` | `Charon livenessProbe http port.` | `3620` |
| `livenessProbe.initialDelaySeconds` | `Charon livenessProbe initial delay in seconds.` | `10` |
| `livenessProbe.periodSeconds` | `Charon livenessProbe period in seconds.` | `5` |
| `readinessProbe.httpGet.path` | `Charon readinessProbe http path.` | `"/metrics"` |
| `readinessProbe.httpGet.port` | `Charon readinessProbe http port.` | `3620` |
| `readinessProbe.initialDelaySeconds` | `Charon readinessProbe initial delay in seconds.` | `5` |
| `readinessProbe.periodSeconds` | `Charon readinessProbe period in seconds.` | `3` |
| `podDisruptionBudget.enabled` | `Enable podDisruptionBudget.` | `false` |
| `podDisruptionBudget.maxUnavailable` | `podDisruptionBudget max unavailable replicas.` | `1` |
| `charon.config.validatorApiAddress` | `Listening address (ip and port) for validator-facing traffic proxying the beacon-node API` | `"0.0.0.0:3600"` |
| `charon.config.p2pTcpAddress` | `Comma-separated list of listening TCP addresses (ip and port) for libP2P traffic. Empty default doesn't bind to local port therefore only supports outgoing connections.` | `"0.0.0.0:3610"` |
| `charon.config.monitoringAddress` | `Listening address (ip and port) for the monitoring API (prometheus, pprof).` | `"0.0.0.0:3620"` |
| `charon.config.p2pUdpAddress` | `Listening UDP address (ip and port) for discv5 discovery. Empty default disables discv5 discovery.` | `"0.0.0.0:3630"` |
| `charon.config.p2pBootnodeRelay` | `Enables using bootnodes as libp2p circuit relays. Useful if some charon nodes are not publicly accessible.` | `true` |
| `charon.config.p2pBootnodes` | `Comma-separated list of discv5 bootnode URLs or ENRs.` | `"http://bootnode.lb.gcp.obol.tech:3640/enr"` |
| `charon.config.beaconNodeEndpoints` | `Comma separated list of one or more beacon node endpoint URLs.` | `""` |
| `charon.config.charonLockFile` | `The path to the cluster lock file defining distributed validator cluster.` | `"/charon/cluster-lock/cluster-lock.json"` |
| `charon.config.privateKeyFile` | `The path to the charon enr private key file.` | `"/charon/charon-enr-private-key/charon-enr-private-key"` |
| `charon.config.logLevel` | `Log level; debug, info, warn or error` | `"debug"` |
| `charon.config.p2pExternalHostname` | `The DNS hostname advertised by libp2p. This may be used to advertise an external DNS.` | `""` |
| `charon.config.noVerify` | `Disables cluster definition and lock file verification.` | `true` |
| `charon.config.jaegerAddress` | `Listening address for jaeger tracing.` | `"jaeger:6831"` |
| `charon.config.jaegerService` | `Service name used for jaeger tracing.` | `"charon"` |
| `charon.secrets.validatorKeys` | `Validators Keys Kubernetes secret name.` | `"validators"` |
| `charon.secrets.enrPrivateKey` | `ENR Private Key Kubernetes secret name.` | `"charon-enr-private-key"` |
| `charon.secrets.clusterlock` | `Cluster Lock Kubernetes secret name.` | `"cluster-lock"` |
