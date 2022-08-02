{{- define "prysm.container" }}
- name: prysm
  {{- if eq .Values.network "gnosis" }}
  image: "{{ .Values.imageRepository.prysmGnosis }}:{{ .Values.imageTag.prysmGnosis }}"
  {{- else }}
  image: "{{ .Values.imageRepository.prysm }}:{{ .Values.imageTag.prysm }}"
  {{- end }}
  imagePullPolicy: {{ .Values.imagePullPolicy }}
  args:
    - "--datadir=/data"
    - "--rpc-host=0.0.0.0"
    - "--rpc-port={{ .Values.executionClientRpcPort }}"
    - "--accept-terms-of-use"
    - "--slots-per-archive-point={{ .Values.dataStorageArchiveFrequency }}"

  {{- if .Values.p2pNodePort.enabled }}
    - "--config-file=/env/init-nodeport"
  {{- else }}
    - "--p2p-host-ip=$(POD_IP)"
    - "--p2p-tcp-port={{ include "prysm.p2pPort" . }}"
    - "--p2p-udp-port={{ include "prysm.p2pPort" . }}"
  {{- end }}

    - "--http-web3provider=http://{{ .fullName }}-{{ .Values.executionClient }}-{{ .replicaID }}:{{ .Values.executionClientRpcPort }}"
    - "--jwt-secret=/secret/jwtsecret"
  {{- if .Values.builderEndpoint }}
    - "--http-mev-relay={{ .Values.builderEndpoint }}"
  {{- end }}

  {{- if .Values.suggestedFeeRecipient }}
    - "--suggested-fee-recipient={{ .Values.suggestedFeeRecipient }}"
  {{- end }}

  {{- if .Values.terminalTotalDifficulty }}
    - "--terminal-total-difficulty-override={{ .Values.terminalTotalDifficulty }}"
  {{- end }}

  {{- if or (eq .Values.network "prater") (eq .Values.network "ropsten") (eq .Values.network "sepolia") }}
    - "--genesis-state=/data/genesis.ssz"
  {{- end }}

  {{- if ne .Values.network "gnosis" }}
    - "--{{ .Values.network }}"
  {{- else }}
    - "--contract-deployment-block=19469077"
    - "--bootstrap-node=/data/gnosis-config/bootnodes.yaml"
    - "--config-file=/data/gnosis-config/config.yaml"
    - "--chain-config-file=/data/gnosis-config/config.yaml"
  {{- end }}

  {{- if .Values.metrics.enabled }}
    - "--monitoring-port={{ .Values.metrics.port }}"
    - "--monitoring-host=0.0.0.0"
  {{- else }}
    - "--disable-monitoring"
  {{- end }}

  {{- range .Values.extraFlags.consensusClient }}
    - {{ . | quote }}
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

{{- define "prysm.p2pPort" -}}
{{- printf "30306" -}}
{{- end }}
