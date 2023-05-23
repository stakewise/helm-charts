#!/bin/bash

VALUES_DIR="tests/values"
CHART_PATH="charts/execution-beacon-copy"

# Iterate through files in the values directory
for file in "$VALUES_DIR"/*.yaml; do
  # Extract the filename without the extension
  filename=$(basename "$file" .yaml)

  # Check if the filename starts with "besu-"
  if [[ $filename == nethermind-* ]]; then
    # Run the Helm command with the filename as an argument and redirect the output to /dev/null
    helm -n test upgrade --install "$filename" "$CHART_PATH" --create-namespace -f "$file" > /dev/null

    # Check the exit code of the Helm command
    if [ $? -eq 0 ]; then
      echo "Run for $filename was successful"
    else
      echo "Run for $filename failed"
    fi
  fi
done
