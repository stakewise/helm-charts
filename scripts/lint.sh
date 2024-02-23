#! /usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly HELM_URL=https://get.helm.sh
readonly HELM_TARBALL=helm-v3.14.2-linux-amd64.tar.gz

main() {
  setup_helm_client
  if ! lint_charts charts; then
      log_error "Not all charts could be packaged and synced!"
      exit 1
  fi
}

setup_helm_client() {
  echo "Setting up Helm client..."
  curl --user-agent curl-ci-sync -sSL -o "$HELM_TARBALL" "$HELM_URL/$HELM_TARBALL"
  tar xzfv "$HELM_TARBALL"
  PATH="$(pwd)/linux-amd64/:$PATH"
  # add dependent helm repos
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add hashicorp https://helm.releases.hashicorp.com
  helm repo add stakewise https://charts.stakewise.io
}

lint_charts() {
  local repo_dir="${1?Specify repo dir}"
  # Loop around each chart.
  for dir in "$repo_dir"/*; do
    helm dependency update "$dir"
    helm lint "$dir" \
      --set global.JWTSecret="lint" \
      --set charon.config.beaconNodeEndpoints="lint" \
      --set settings.executionEndpoints="lint" \
      --set settings.consensusEndpoints="lint" \
      --set settings.vault="lint" \
      --set beaconChainRpcEndpoints="lint" \
      --set suggestedFeeRecipient="lint"
  done
}


log_error() {
    printf '\e[31mERROR: %s\n\e[39m' "$1" >&2
}

main