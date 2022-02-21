{{/*
Expand the name of the chart.
*/}}
{{- define "operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "operator.labels" -}}
helm.sh/chart: {{ include "operator.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
component: validator
{{- end }}

{{/*
Additional components labels
*/}}
{{- define "validator.labels" -}}         component: validator            {{- end }}

{{/*
Selector labels
*/}}
{{- define "operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
component: validator
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Update permissions on files inside /data directory
*/}}
{{- define "init-chown" -}}
- name: init-chown
  image: "{{ .Values.initImageBusybox.repository }}:{{ .Values.initImageBusybox.tag }}"
  imagePullPolicy: {{ .Values.initImageBusybox.pullPolicy }}
  securityContext:
    runAsUser: 0
  command: ["chown", "-R", "{{ .Values.securityContext.runAsUser }}:{{ .Values.securityContext.runAsUser }}", "/data"]
  volumeMounts:
    - name: data
      mountPath: /data
{{- end }}

{{/*
Write current validator info to /data directory
*/}}
{{- define "init-validator-info" -}}
- name: init-validator-info
  image: "{{ .Values.initImageBusybox.repository }}:{{ .Values.initImageBusybox.tag }}"
  imagePullPolicy: {{ .Values.initImageBusybox.pullPolicy }}
  securityContext:
    runAsUser: 0
  command: ["/bin/sh", "-c", "echo {{ .Values.type }} > /data/validator.type"]
  volumeMounts:
    - name: data
      mountPath: /data
{{- end }}

{{/*
Validator beacon node
*/}}
{{- define "beacon-rpc-node" -}}
{{- if eq $.Values.type "prysm" }}
- "--beacon-rpc-provider={{ $.Values.beaconChainRpcEndpoints | join "," }}"
{{- else if eq $.Values.type "lighthouse" }}
- "--beacon-nodes={{ $.Values.beaconChainRpcEndpoints | join "," }}"
{{- else if eq $.Values.type "teku" }}
{{- with (first $.Values.beaconChainRpcEndpoints) }}
- "--beacon-node-api-endpoint={{ . }}"
{{- end }}
{{- end }}
{{- end }}

{{/*
Validator graffiti
*/}}
{{- define "validator-graffiti" -}}
{{- if $.Values.graffiti }}
{{- if or (eq $.Values.type "prysm") (eq $.Values.type "lighthouse") }}
- "--graffiti={{ $.Values.graffiti }}"
{{- else if eq $.Values.type "teku" }}
- "--validators-graffiti={{ $.Values.graffiti }}"
{{- end }}
{{- end }}
{{- end }}
