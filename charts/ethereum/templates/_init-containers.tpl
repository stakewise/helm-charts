{{- define "init.nodeport" -}}
- name: nodeport
  image: "{{ .Values.p2pNodePort.initContainer.image.repository }}:{{ .Values.p2pNodePort.initContainer.image.tag }}"
  imagePullPolicy: {{.Values.p2pNodePort.initContainer.image.pullPolicy }}
  securityContext:
    runAsNonRoot: false
    runAsUser: 0
  env:
    - name: POD_NAME
      valueFrom:
        fieldRef:
          fieldPath: metadata.name
    - name: POD_NAMESPACE
      valueFrom:
        fieldRef:
          fieldPath: metadata.namespace
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
  command:
    - sh
    - -c
    - >
      echo "Namespace: ${POD_NAMESPACE} Pod: ${POD_NAME}";
  {{- if eq .Values.p2pNodePort.type "LoadBalancer" }}
      until [ -n "$(kubectl -n ${POD_NAMESPACE} get svc/${POD_NAME} -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" ]; do echo "Waiting for load balancer gets an IP" && sleep 10; done;
      export EXTERNAL_PORT=$(kubectl -n ${POD_NAMESPACE} get services -l "pod in (${POD_NAME}), type in (p2p)" -o jsonpath='{.items[0].spec.ports[0].nodePort}');
      export EXTERNAL_IP=$(kubectl -n ${POD_NAMESPACE} get svc/${POD_NAME} -o jsonpath='{.status.loadBalancer.ingress[0].ip}');
  {{- else }}
      export EXTERNAL_PORT=$(kubectl get services -l "pod in (${POD_NAME}), type in (p2p)" -o jsonpath='{.items[0].spec.ports[0].nodePort}');
      export EXTERNAL_IP=$(kubectl get nodes "${NODE_NAME}" -o jsonpath='{.status.addresses[?(@.type=="ExternalIP")].address}');
  {{- end }}
  {{- if and (eq .mode "consensusClient") (eq .client "prysm") }}
      echo "p2p-host-ip: $EXTERNAL_IP"   > /env/init-nodeport;
      echo "p2p-tcp-port: $EXTERNAL_PORT" >>  /env/init-nodeport;
      echo "p2p-udp-port: $EXTERNAL_PORT" >>  /env/init-nodeport;
  {{- else }}
      echo "EXTERNAL_PORT=$EXTERNAL_PORT" >  /env/init-nodeport;
      echo "EXTERNAL_IP=$EXTERNAL_IP"     >> /env/init-nodeport;
  {{- end }}
      cat /env/init-nodeport;
  volumeMounts:
    - name: env
      mountPath: /env
{{- end }}

{{- define "init.chown" -}}
- name: chown
  image: "{{ .Values.initImage.repository }}:{{ .Values.initImage.tag }}"
  imagePullPolicy: {{ .Values.initImage.pullPolicy }}
  securityContext:
    runAsUser: 0
  command:
    - sh
    - -c
    - >
      chown -R {{ (pluck .client .Values.securityContext | first).runAsUser }}:{{ (pluck .client .Values.securityContext | first).runAsUser }} /data;
  volumeMounts:
    - name: data
      mountPath: /data
{{- end }}

{{- define "prysm.genesis" -}}
{{- if or (eq .Values.network "prater") (eq .Values.network "goerli") (eq .Values.network "ropsten") (eq .Values.network "sepolia") }}
- name: download-genesis-state
  image: "curlimages/curl:latest"
  imagePullPolicy: {{ .Values.initImage.pullPolicy }}
  command: ['/bin/sh', '/data/scripts/entrypoint.sh']
  volumeMounts:
    - name: data
      mountPath: /data
    - name: scripts
      mountPath: /data/scripts
{{- end }}
{{- end }}
