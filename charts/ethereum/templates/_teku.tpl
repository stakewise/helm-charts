{{- define "teku.container" }}
- name: teku
  image: "{{ .Values.imageRepository.teku }}:{{ .Values.imageTag.teku }}"
  imagePullPolicy: {{ .Values.imagePullPolicy }}
  command:
    - sh
    - -ac
    - >
    {{- if .Values.p2pNodePort.enabled }}
      . /env/init-nodeport;
    {{- end }}
      exec /opt/teku/bin/teku
      --network={{ .Values.network }}
      --data-beacon-path=/data/teku/beacon
      --data-path=/data/teku
      --data-storage-archive-frequency={{ .Values.dataStorageArchiveFrequency }}
      --ee-endpoint=http://{{ .fullName }}-{{ .Values.executionClient }}-{{ .replicaID }}:{{ .Values.executionClientRpcPort }}
      --ee-jwt-secret-file=/secret/jwtsecret

    {{- if .Values.builderEndpoint }}
      --builder-endpoint={{ .Values.builderEndpoint }}
    {{- end }}

      --p2p-enabled=true
      --p2p-port={{ include "teku.p2pPort" . }}
    {{- if .Values.p2pNodePort.enabled }}
      --p2p-advertised-ip=$EXTERNAL_IP
      --p2p-advertised-port=$EXTERNAL_PORT
    {{- else }}
      --p2p-advertised-ip=$(POD_IP)
      --p2p-advertised-port={{ include "teku.p2pPort" . }}
    {{- end }}

      --rest-api-enabled=true
      --rest-api-host-allowlist=*
      --rest-api-interface=0.0.0.0
      --rest-api-port={{ .Values.consensusClientRpcPort }}
      --rest-api-cors-origins=*
  
    {{- if .Values.metrics.enabled }}
      --metrics-enabled={{ .Values.metrics.enabled }}
      --metrics-categories=JVM,PROCESS,BEACON,DISCOVERY,EVENTBUS,EXECUTOR,NETWORK,STORAGE,STORAGE_HOT_DB,STORAGE_FINALIZED_DB,REMOTE_VALIDATOR,VALIDATOR,VALIDATOR_PERFORMANCE
      --metrics-host-allowlist=*
      --metrics-interface=0.0.0.0
      --metrics-port={{ .Values.metrics.port }}
    {{- end }}

    {{- range .Values.extraFlags.consensusClient }}
      {{ . | quote }}
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

{{- define "teku.p2pPort" -}}
{{- printf "30308" -}}
{{- end }}
