{{- define "graph-node.indexersList" -}}
  {{- $replicaCount := .Values.replicaCount -}}
  {{- $namePrefix := include "common.names.fullname" . -}}
  {{- range $i := until (int $replicaCount) }}
    {{- printf "\"%s-%d\"" $namePrefix $i -}}{{- if lt $i (add (int $replicaCount) -1) }}, {{- end }}
  {{- end }}
{{- end -}}