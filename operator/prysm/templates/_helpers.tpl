{{/*
Expand the name of the chart.
*/}}
{{- define "prysm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prysm.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "beacon.fullname" -}}
{{- printf "%s-%s" .Release.Name "beacon" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bootnode.fullname" -}}
{{- printf "%s-%s" .Release.Name "bootnode" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "slasher.fullname" -}}
{{- printf "%s-%s" .Release.Name "slasher" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prysm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prysm.labels" -}}
helm.sh/chart: {{ include "prysm.chart" . }}
{{ include "prysm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "beacon.labels" -}}
{{ include "prysm.labels" . }}
component: beacon
{{- end }}

{{- define "bootnode.labels" -}}
{{ include "prysm.labels" . }}
component: bootnode
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prysm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prysm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "beacon.selectorLabels" -}}
{{ include "prysm.selectorLabels" . }}
component: beacon
{{- end }}

{{- define "bootnode.selectorLabels" -}}
{{ include "prysm.selectorLabels" . }}
component: bootnode
{{- end }}

{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
