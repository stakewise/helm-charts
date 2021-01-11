{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "geth.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "geth.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bootnode.fullname" -}}
{{- printf "%s-%s" .Release.Name "bootnode" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bootnode.serviceHost" -}}
{{- printf "%s_SERVICE_HOST" (include "bootnode.fullname" .) | upper | replace "-" "_" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "geth.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
