{{- if $.Values.svc.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Values.deployment.projectName }}-alb
  namespace: {{ .Values.deployment.namespace }}
  annotations:
    kubernetes.io/ingress.class: "gce"
    {{- if $.Values.svc.ingress.managedCertificate.enabled }}
    networking.gke.io/managed-certificates: "{{ .Values.deployment.projectName }}-cert"
    networking.gke.io/v1beta1.FrontendConfig: "http-to-https"
    {{- end }}
spec:
  rules:
{{ toYaml .Values.svc.ingress.rules | indent 2 }}
{{- end -}}
