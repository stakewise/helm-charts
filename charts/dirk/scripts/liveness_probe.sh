#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

multiplier=120
INDEX=$(cat /data/dirk/index)
CHECK_FILE=/data/dirk/dirty


if test -f "$CHECK_FILE"; then
  echo "$CHECK_FILE exists."
  wait_seconds=$((INDEX * multiplier))
  echo "Wait for $wait_seconds"
  sleep $wait_seconds

  exit 1
fi