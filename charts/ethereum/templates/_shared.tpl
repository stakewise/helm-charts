{{- define "volumeMounts" }}
volumeMounts:
  - name: data
    mountPath: /data
  - name: jwtsecret
    mountPath: /secret
    readOnly: true
{{- if and (eq .mode "consensusClient") (eq .Values.consensusClient "prysm") (eq .Values.network "gnosis") }}
  - name: gnosis-config
    mountPath: /data/gnosis-config
{{- end }}
{{- if .Values.p2pNodePort.enabled }}
  - name: env
    mountPath: /env
{{- end }}
{{- end }}

{{- define "sidecar" }}
- name: sidecar
  image: "{{ .Values.sidecar.repository }}:{{ .Values.sidecar.tag }}"
  imagePullPolicy: {{ .Values.sidecar.pullPolicy }}
  env:
    - name: SERVER_BINDADDR
      value: "{{ .Values.sidecar.bindAddr }}:{{ .Values.sidecar.bindPort }}"
    - name: CLIENT_PORT
      value: {{ .Values.rpc.port | quote }}
  ports:
    - containerPort: {{ .Values.sidecar.bindPort }}
      name: sidecar
      protocol: TCP
{{- if .Values.livenessProbe.enabled }}
  livenessProbe:
    initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.livenessProbe.timeoutSeconds }}
    periodSeconds: {{ .Values.livenessProbe.periodSeconds }}
    failureThreshold: {{ .Values.livenessProbe.failureThreshold }}
    successThreshold: {{ .Values.livenessProbe.successThreshold }}
    httpGet:
      path: {{ pluck .mode .Values.livenessProbe.httpGet.path | first }}
      port: {{ .Values.livenessProbe.httpGet.port }}
      scheme: {{ .Values.livenessProbe.httpGet.scheme }}
{{- end }}
{{- if .Values.readinessProbe.enabled }}
  readinessProbe:
    initialDelaySeconds: {{ .Values.readinessProbe.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.readinessProbe.timeoutSeconds }}
    periodSeconds: {{ .Values.readinessProbe.periodSeconds }}
    failureThreshold: {{ .Values.readinessProbe.failureThreshold }}
    successThreshold: {{ .Values.readinessProbe.successThreshold }}
    httpGet:
      path: {{ pluck .mode .Values.readinessProbe.httpGet.path | first }}
      port: {{ .Values.readinessProbe.httpGet.port }}
      scheme: {{ .Values.readinessProbe.httpGet.scheme }}
{{- end }}
{{- end }}