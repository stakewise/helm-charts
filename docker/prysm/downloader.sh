#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

set -x

EXECUTABLE_NAME=${1}
EXECUTABLE_FULL_NAME=${EXECUTABLE_NAME}-${VERSION}-${TARGETPLATFORM/\//\-}
echo "VERSION, ${VERSION}"
echo "TARGETPLATFORM, ${TARGETPLATFORM}"


wget -q https://github.com/prysmaticlabs/prysm/releases/download/"${VERSION}"/"${EXECUTABLE_FULL_NAME}"
wget -q https://github.com/prysmaticlabs/prysm/releases/download/"${VERSION}"/"${EXECUTABLE_FULL_NAME}".sha256
ls -la .
sha256sum -c "${EXECUTABLE_FULL_NAME}".sha256

mkdir -p /app/cmd/"${EXECUTABLE_NAME}"/
mv "${EXECUTABLE_FULL_NAME}" /app/cmd/"${EXECUTABLE_NAME}"/"${EXECUTABLE_NAME}"

chmod +x /app/cmd/"${EXECUTABLE_NAME}"/"${EXECUTABLE_NAME}"