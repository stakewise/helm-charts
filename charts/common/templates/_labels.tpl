{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "common.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" $ }}
helm.sh/chart: {{ include "common.names.chart" $ }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{- toYaml .Values.additionalLabels | nindent 0 }}
{{- end }}
{{- end -}}

{{- define "common.labels.statefulset" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chartWithoutVersion" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{- toYaml .Values.additionalLabels | nindent 0 }}
{{- end }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.additionalLabels }}
{{- toYaml .Values.additionalLabels | nindent 0 }}
{{- end }}
{{- end -}}
