{{- define "nethermind.container" }}
- name: nethermind
  image: "{{ .Values.imageRepository.nethermind }}:{{ .Values.imageTag.nethermind }}"
  imagePullPolicy: {{ .Values.imagePullPolicy }}
  workingDir: /data
  command:
    - sh
    - -ac
    - >
    {{- if .Values.p2pNodePort.enabled }}
      . /env/init-nodeport;
    {{- end }}
      exec /nethermind/Nethermind.Runner
    {{- if eq .Values.network "gnosis" }}
      --config=xdai
    {{- else }}
      --config={{ .Values.network }}
    {{- end }}
      --datadir=/data
      --JsonRpc.Enabled=true
      --JsonRpc.EnabledModules={{ .Values.executionClientApiModules }}
      --JsonRpc.Host=0.0.0.0
      --JsonRpc.Port={{ .Values.executionClientRpcPort }}
      --JsonRpc.JwtSecretFile=/secret/jwtsecret
      --HealthChecks.Enabled=true
    {{- if .Values.metrics.enabled }}
      --Metrics.Enabled={{ .Values.metrics.enabled }}
      --Metrics.ExposePort={{ .Values.metrics.port }}
    {{- end }}
    {{- if .Values.p2pNodePort.enabled }}
      --Network.ExternalIp=$EXTERNAL_IP
      --Network.P2PPort=$EXTERNAL_PORT
      --Network.DiscoveryPort=$EXTERNAL_PORT
    {{- else }}
      --Network.ExternalIp=$(POD_IP)
      --Network.P2PPort={{ include "nethermind.p2pPort" . }}
      --Network.DiscoveryPort={{ include "nethermind.p2pPort" . }}
    {{- end }}
      --Merge.Enabled={{ .Values.mergeEnabled }}
    {{- if .Values.builderEndpoint }}
      --Merge.BuilderRelayUrl={{ .Values.builderEndpoint }}
    {{- end }}
    {{- if .Values.terminalTotalDifficulty }}
      --Merge.TerminalTotalDifficulty={{ .Values.terminalTotalDifficulty }}
    {{- end }}
    {{- range .Values.extraFlags.executionClient }}
      {{ . | quote }}
    {{- end }}
  ports:
    - name: rpc
      containerPort: {{ .Values.executionClientRpcPort }}
      protocol: TCP
    {{- if .Values.metrics.enabled }}
    - name: metrics
      containerPort: {{ .Values.metrics.port }}
      protocol: TCP
    {{- end }}
  env:
    - name: POD_IP
      valueFrom:
        fieldRef:
          fieldPath: status.podIP
  resources:
    {{- toYaml .Values.resources.executionClient | nindent 4 }}
  {{- include "volumeMounts" . | nindent 2 }}
{{- end }}

{{- define "nethermind.p2pPort" }}
{{- printf "30304" -}}
{{- end }}
