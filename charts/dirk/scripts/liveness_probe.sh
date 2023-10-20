#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

multiplier=$1
location="/data/dirk"
location="/Users/aivaras/projects/nethermind-charts/dirk"
CHECK_FILE=${location}/dirty


if test -f "$CHECK_FILE"; then
  echo "$CHECK_FILE exists."

  start_time=$(cat ${CHECK_FILE})
  current_timestamp=$(date '+%s')

  index=$(cat ${location}/index)
  wait_seconds=$((index * multiplier))
  cutoff_timestamp=$((start_time + wait_seconds))
  remaining_seconds=$((current_timestamp - cutoff_timestamp))

  if (( current_timestamp > cutoff_timestamp )); then
    echo "Wait time completed. Should exit."
    exit 1
  else
    echo "Wait for ${remaining_seconds} seconds to exit"
  fi

fi