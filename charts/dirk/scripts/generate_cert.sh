#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

set -x


generate_certs() {
LOCATION=$1
CA_CERT_NAME=$2
CERT_NAME=$3

mkdir -p "${LOCATION}"
pushd "${LOCATION}"

if [ ! -f "${CA_CERT_NAME}.key" ]
then
  echo "Generating authority key"
  openssl genrsa -des3 -out "${CA_CERT_NAME}_pass.key" 4096
  openssl rsa -in "${CA_CERT_NAME}_pass.key" -out "${CA_CERT_NAME}.key"
fi

if [ ! -f "${CA_CERT_NAME}.crt" ]
then
  echo "Generating authority crt"
  openssl req -x509 -new -nodes -key "${CA_CERT_NAME}.key" -sha256 -days 1825 -out "${CA_CERT_NAME}.crt"
fi

cat >"${CERT_NAME}.ext" <<EOEXT
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = "${CERT_NAME}"
EOEXT

  openssl genrsa -out "${CERT_NAME}.key" 4096
  openssl req -out "${CERT_NAME}.csr" -key "${CERT_NAME}.key" -new -subj "/CN=${CERT_NAME}" -addext "subjectAltName=DNS:${CERT_NAME}"
  openssl x509 -req -in "${CERT_NAME}.csr" -CA "${CA_CERT_NAME}.crt" -CAkey "${CA_CERT_NAME}.key" -CAcreateserial -out "${CERT_NAME}.crt" -days 1825 -sha256 -extfile "${CERT_NAME}.ext"

popd
}

generate_certs "$@"