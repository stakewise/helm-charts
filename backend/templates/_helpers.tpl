{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backend.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "admin.fullname" -}}
{{- printf "%s-%s" (include "backend.fullname" .) "admin" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "api.fullname" -}}
{{- printf "%s-%s" (include "backend.fullname" .) "api" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "emails.fullname" -}}
{{- printf "%s-%s" (include "backend.fullname" .) "emails" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "polling.fullname" -}}
{{- printf "%s-%s" (include "backend.fullname" .) "polling" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "backend.labels" -}}
app: {{ template "backend.name" . }}
chart: {{ template "backend.chart" . }}
release: {{ .Release.Name | quote }}
heritage: {{ .Release.Service | quote }}
{{- end -}}

{{- define "backend.selectorLabels" -}}
app: {{ template "backend.name" . }}
release: {{ .Release.Name | quote }}
component: "admin"
{{- end -}}

{{/*
Common labels
*/}}
{{- define "backend.labels" -}}
helm.sh/chart: {{ include "backend.chart" . }}
{{ include "backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
