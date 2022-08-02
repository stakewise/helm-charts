{{- define "lighthouse.container" }}
- name: lighthouse
  image: "{{ .Values.imageRepository.lighthouse }}:{{ .Values.imageTag.lighthouse }}"
  imagePullPolicy: {{ .Values.imagePullPolicy }}
  command:
    - sh
    - -ac
    - >
    {{- if .Values.p2pNodePort.enabled }}
      . /env/init-nodeport;
    {{- end }}
      exec lighthouse
      bn
      --staking
      --http
      --http-port={{ .Values.consensusClientRpcPort }}
      --http-address=0.0.0.0
      --http-allow-origin=*
      --execution-endpoint=http://{{ .fullName }}-{{ .Values.executionClient }}-{{ .replicaID }}:{{ .Values.executionClientRpcPort }}
      --execution-jwt=/secret/jwtsecret
      --datadir=/data
      --network={{ .Values.network }}
      --disable-upnp
      --disable-enr-auto-update
      --discovery-port={{ include "lighthouse.p2pPort" . }}
      --slots-per-restore-point={{ .Values.dataStorageArchiveFrequency }}
    
    {{- if .Values.builderEndpoint }}
      --builder={{ .Values.builderEndpoint }}
    {{- end }}

    {{- if .Values.p2pNodePort.enabled }}
      --enr-address=$EXTERNAL_IP
      --enr-tcp-port=$EXTERNAL_PORT
      --enr-udp-port=$EXTERNAL_PORT
    {{- else }}
      --enr-address=$(POD_IP)
      --enr-tcp-port={{ include "lighthouse.p2pPort" . }}
      --enr-udp-port={{ include "lighthouse.p2pPort" . }}
    {{- end }}

    {{- if .Values.metrics.enabled }}
      --metrics
      --metrics-port={{ .Values.metrics.port }}
      --metrics-address=0.0.0.0
    {{- end }}

    {{- range .Values.extraFlags.consensusClient }}
      {{ . }}
    {{- end }}
  ports:
    - name: rpc
      containerPort: {{ .Values.consensusClientRpcPort }}
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
    {{- toYaml .Values.resources.consensusClient | nindent 4 }}
  {{- include "volumeMounts" . | nindent 2 }}
{{- end }}

{{- define "lighthouse.p2pPort" -}}
{{- printf "30307" -}}
{{- end }}
