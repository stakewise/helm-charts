{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "periodic-tasks.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "periodic-tasks.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "periodic-tasks.labels" -}}
helm.sh/chart: {{ include "periodic-tasks.chart" . }}
{{ include "periodic-tasks.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "periodic-tasks.selectorLabels" -}}
app.kubernetes.io/name: {{ include "periodic-tasks.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
repository: {{ .Values.repository | default "none" }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "periodic-tasks.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "periodic-tasks.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

