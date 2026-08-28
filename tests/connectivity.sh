#!/usr/bin/env bash

set -e

REGION="ap-south-1"
INSTANCE_ID="$1"

if [ -z "$INSTANCE_ID" ]; then
  echo "Usage: ./connectivity.sh <instance-id>"
  exit 1
fi

echo "====================================="
echo "Phase 5 Connectivity Test"
echo "====================================="

echo
echo "Instance:"
echo "$INSTANCE_ID"

echo
echo "Starting SSM session..."

aws ssm start-session \
  --target "$INSTANCE_ID" \
  --region "$REGION"
