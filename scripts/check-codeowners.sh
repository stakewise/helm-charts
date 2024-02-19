#!/bin/bash

cat <<EOF
# See https://github.com/scottrigby/prometheus-helm-charts/issues/12
# https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners
# https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners#codeowners-syntax

# The repo admins team will be the default owners for everything in the repo.
# Unless a later match takes precedence, they will be requested for review when someone opens a pull request.
* @NethermindEth/Angkor/angkor-validator-operators

/.github/workflows/ @NethermindEth/Angkor/angkor-validator-operators @AntiD2ta @aivarasko @matilote

EOF

for DIR in ./charts/*
do
  FILE="$DIR/Chart.yaml"
  DIR="${DIR/#.\///}"
  MAINTAINERS=()
  while IFS='' read -r line; do
    MAINTAINERS+=("$line")
  done < <(yq e '.maintainers.[].name' "$FILE"| sed 's/^/@/' | sort --ignore-case)
  echo "$DIR"/ "${MAINTAINERS[@]}"
done