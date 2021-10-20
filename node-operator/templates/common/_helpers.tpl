{{/*
Expand the name of the chart.
*/}}
{{- define "node-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "node-operator.fullname" -}}
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
{{- define "node-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "node-operator.labels" -}}
helm.sh/chart: {{ include "node-operator.chart" . }}
{{ include "node-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Additional components labels
*/}}
{{- define "common.labels" -}}            component: common               {{- end }}
{{- define "geth.labels" -}}              component: geth                 {{- end }}
{{- define "openethereum.labels" -}}      component: openethereum         {{- end }}
{{- define "prysm-beacon.labels" -}}      component: prysm-beacon         {{- end }}
{{- define "lighthouse-beacon.labels" -}} component: lighthouse-beacon    {{- end }}
{{- define "validator.labels" -}}         component: validator            {{- end }}

{{/*
Selector labels
*/}}
{{- define "node-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "node-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "node-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Update permissions on files inside /data directory
*/}}
{{- define "init-chown" -}}
- name: init-chown
  image: "{{ .Values.initImage.repository }}:{{ .Values.initImage.tag }}"
  imagePullPolicy: {{ .Values.initImage.pullPolicy }}
  securityContext:
    runAsUser: 0
  command: ["chown", "-R", "{{ .Values.securityContext.runAsUser }}:{{ .Values.securityContext.runAsUser }}", "/data"]
  volumeMounts:
    - name: data
      mountPath: /data
{{- end }}

{{/*
Validator beacon node
*/}}
{{- define "beacon-rpc-node" -}}
{{- if $.Values.validator.beaconChainRpcEndpoint }}
{{- if eq $.Values.validator.type "prysm" }}
- "--beacon-rpc-provider={{ $.Values.validator.beaconChainRpcEndpoint }}"
{{- else if eq $.Values.validator.type "lighthouse" }}
- "--beacon-nodes={{ $.Values.validator.beaconChainRpcEndpoint }}"
{{- end }}
{{- else }}
{{- if eq $.Values.validator.type "prysm" }}
- "--beacon-rpc-provider={{ template "node-operator.fullname" $ }}-prysm-beacon:4000"
{{- else if eq $.Values.validator.type "lighthouse" }}
- "--beacon-nodes=http://{{ template "node-operator.fullname" $ }}-lighthouse-beacon:5052"
{{- end }}
{{- end }}
{{- end }}

{{/*
Validator graffiti
*/}}
{{- define "validator-graffiti" -}}
{{- if $.Values.validator.graffiti }}
- "--graffiti={{ $.Values.validator.graffiti }}"
{{- end }}
{{- end }}
