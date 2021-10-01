{{/*
Expand the name of the chart.
*/}}
{{- define "geth.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "geth.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "node.fullname" -}}
{{- printf "%s-%s" .Release.Name "node" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "genesis.fullname" -}}
{{- printf "%s-%s" .Release.Name "genesis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "geth.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "geth.labels" -}}
helm.sh/chart: {{ include "geth.chart" . }}
{{ include "geth.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "genesis.labels" -}}
{{ include "geth.labels" . }}
component: "genesis"
{{- end }}

{{- define "node.labels" -}}
{{ include "geth.labels" . }}
component: "node"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "geth.selectorLabels" -}}
app.kubernetes.io/name: {{ include "geth.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "node.selectorLabels" -}}
{{ include "geth.selectorLabels" . }}
component: node
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
