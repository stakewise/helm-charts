{{- define "erigon.container" }}
- name: erigon
  image: "{{ .Values.imageRepository.erigon }}:{{ .Values.imageTag.erigon }}"
  imagePullPolicy: {{ .Values.imagePullPolicy }}
  command:
    - sh
    - -ac
    - >
    {{- if .Values.p2pNodePort.enabled }}
      . /env/init-nodeport;
    {{- end }}
      exec erigon
      --datadir=/data
      --chain={{ .Values.network }}
    {{- if .Values.p2pNodePort.enabled }}
      --nat=extip:$EXTERNAL_IP
      --port=$EXTERNAL_PORT
    {{- else }}
      --nat=extip:$(POD_IP)
      --port={{ include "erigon.p2pPort" $ }}
    {{- end }}
    {{- if .Values.terminalTotalDifficulty }}
      --override.terminaltotaldifficulty={{ .Values.terminalTotalDifficulty }}
    {{- end }}
      --http.vhosts=*
      --http.corsdomain=*
      --http.api={{ .Values.executionClientApiModules }}
      --engine.addr=0.0.0.0
      --engine.port={{ .Values.executionClientRpcPort }}
      --authrpc.jwtsecret=/secret/jwtsecret
    {{- if .Values.metrics.enabled }}
      --metrics
      --metrics.addr=0.0.0.0
      --metrics.port={{ .Values.metrics.port }}
    {{- end }}
    {{- range .Values.extraFlags }}
      {{ . }}
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

{{- define "erigon.p2pPort" }}
{{- printf "30305" -}}
{{- end }}
