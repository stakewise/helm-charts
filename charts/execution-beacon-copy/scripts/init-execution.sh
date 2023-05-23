#!/bin/sh

echo "Namespace: ${POD_NAMESPACE} Pod: ${POD_NAME}";
{{- if .Values.p2pNodePort.enabled }}
{{- if eq .Values.p2pNodePort.type "LoadBalancer" }}
    until [ -n "$(kubectl -n ${POD_NAMESPACE} get svc/${POD_NAME} -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" ]; do echo "Waiting for load balancer gets an IP" && sleep 10; done;
    export EXTERNAL_PORT=$(kubectl -n ${POD_NAMESPACE} get services -l "client=execution,pod in (${POD_NAME}), type in (p2p)" -o jsonpath='{.items[0].spec.ports[0].nodePort}');
    export EXTERNAL_IP=$(kubectl -n ${POD_NAMESPACE} get svc/${POD_NAME} -o jsonpath='{.status.loadBalancer.ingress[0].ip}');
{{- else }}
    export EXTERNAL_PORT=$(kubectl get services -l "client=execution,pod in (${POD_NAME}), type in (p2p)" -o jsonpath='{.items[0].spec.ports[0].nodePort}');
    export EXTERNAL_IP=$(kubectl get nodes "${NODE_NAME}" -o jsonpath='{.status.addresses[?(@.type=="ExternalIP")].address}');
{{- end }}
    echo "EXTERNAL_PORT=$EXTERNAL_PORT" >  /env/init-nodeport;
    echo "EXTERNAL_IP=$EXTERNAL_IP"     >> /env/init-nodeport;
    cat /env/init-nodeport;
{{- end }}
{{- if and .Values.persistence.enabled .Values.initChownData }}
    mkdir -p /data && chown -R {{ .Values.securityContext.runAsUser }}:{{ .Values.securityContext.runAsUser }} /data;
{{- end }}