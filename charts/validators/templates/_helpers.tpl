{{/*
Expand the name of the chart.
*/}}
{{- define "validators.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "validators.fullname" -}}
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
Extract the last part of a string after the hyphen ("-"). Defining the validators owner.
*/}}
{{- define "validators.ownership" -}}
{{- $fullname := .Values.fullnameOverride }}
{{- if not $fullname }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $fullname = printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- $parts := split "-" $fullname }}
{{- index $parts (sub (len $parts) 1) }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "validators.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "validators.labels" -}}
helm.sh/chart: {{ include "validators.chart" . }}
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
{{- define "validators.selectorLabels" -}}
app.kubernetes.io/name: {{ include "validators.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
component: validator
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "validators.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "validators.fullname" .) .Values.serviceAccount.name }}
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
Validator beacon node
*/}}
{{- define "beacon-rpc-node" -}}
{{- if eq $.Values.type "prysm" }}
- "--beacon-rpc-provider={{ $.Values.beaconChainRpcEndpoints | join "," }}"
{{- else if eq $.Values.type "lighthouse" }}
- "--beacon-nodes={{ $.Values.beaconChainRpcEndpoints | join "," }}"
{{- else if eq $.Values.type "teku" }}
- "--beacon-node-api-endpoint={{ $.Values.beaconChainRpcEndpoints | join "," }}"
{{- else if eq $.Values.type "nimbus" }}
{{- range $.Values.beaconChainRpcEndpoints }}
- "--beacon-node={{ . }}"
{{- end }}
{{- else if eq $.Values.type "lodestar" }}
- --beaconNodes={{ $.Values.beaconChainRpcEndpoints | join "," }}
{{- end }}
{{- end }}

{{/*
Validator graffiti
*/}}
{{- define "validator-graffiti" -}}
{{- if $.Values.graffiti }}
{{- if eq $.Values.type "teku" }}
- "--validators-graffiti={{ $.Values.graffiti }}"
{{- else }}
- "--graffiti={{ $.Values.graffiti }}"
{{- end }}
{{- end }}
{{- end }}

{{- define "web3signer" -}}
{{- if $.Values.web3signerEndpoint }}{{ $.Values.web3signerEndpoint }}{{- else }}http://{{ $.Values.global.project }}-{{ $.Values.global.label }}-web3signer:6174
{{- end }}
{{- end }}

{{- define "flatten_list" -}}
  {{- $output := list -}}
  {{- range . -}}
    {{- if (kindIs "slice" . ) -}}
      {{- $output = (concat $output ( get (fromYaml (include "flatten_list" . ) )  "list" ) ) -}}
    {{- else -}}
      {{- $output = (append $output . ) -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml (dict "list" $output) -}}
{{- end -}}

{{- define "flatten" -}}
  {{- get ( fromYaml (include "flatten_list" . ) ) "list" | uniq | join "," }}
{{- end -}}
