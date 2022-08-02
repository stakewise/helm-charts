{{- define "geth.container" }}
- name: geth
  image: "{{ .Values.imageRepository.geth }}:{{ .Values.imageTag.geth }}"
  imagePullPolicy: {{ .Values.imagePullPolicy }}
  command:
    - sh
    - -ac
    - >
    {{- if .Values.p2pNodePort.enabled }}
      . /env/init-nodeport;
    {{- end }}
      exec geth
      --{{ .Values.network }}
      --datadir=/data
      --ethash.dagdir=/data/.ethash
      --ipcdisable
      --authrpc.jwtsecret=/secret/jwtsecret
      --authrpc.addr=0.0.0.0
      --authrpc.port={{ .Values.executionClientRpcPort }}
      --authrpc.vhosts=*
      --http
      --http.addr=0.0.0.0
      --http.vhosts=*
      --http.api={{ .Values.executionClientApiModules }}
    {{- if .Values.p2pNodePort.enabled }}
      --nat=extip:$EXTERNAL_IP
      --port=$EXTERNAL_PORT
    {{- else }}
      --nat=extip:$(POD_IP)
      --port={{ include "geth.p2pPort" $ }}
    {{- end }}
    {{- if .Values.terminalTotalDifficulty }}
      --override.terminaltotaldifficulty={{ .Values.terminalTotalDifficulty }}
    {{- end }}
    {{- if .Values.metrics.enabled }}
      --metrics
      --pprof
      --pprof.addr=0.0.0.0
      --pprof.port={{ .Values.metrics.port }}
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

{{- define "geth.p2pPort" -}}
{{- printf "30303" -}}
{{- end }}
