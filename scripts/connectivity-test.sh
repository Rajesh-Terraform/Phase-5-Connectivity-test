#!/usr/bin/env bash

set -euo pipefail

echo "========================================"
echo "PHASE 5 CONNECTIVITY TEST"
echo "========================================"

echo
echo "[1/5] Identity"
aws sts get-caller-identity

echo
echo "[2/5] S3 endpoint"

aws s3api list-buckets \
  --query 'Buckets[0:3].Name' \
  --output table

echo "S3 endpoint test PASSED"

echo
echo "[3/5] CloudWatch endpoint"

aws cloudwatch list-metrics \
  --max-items 1 \
  --output json

echo "CloudWatch endpoint test PASSED"

echo
echo "[4/5] Hub/TGW connectivity"

if curl \
    --connect-timeout 5 \
    --max-time 10 \
    "http://${HUB_TEST_IP}:${HUB_TEST_PORT}/"; then

    echo "TGW/HUB connectivity PASSED"
else
    echo "TGW/HUB connectivity FAILED"
    exit 1
fi

echo
echo "[5/5] Internet isolation"

if curl \
    --connect-timeout 5 \
    --max-time 10 \
    http://1.1.1.1/; then

    echo "ERROR: Internet is reachable!"
    exit 1
else
    echo "Internet isolation PASSED"
fi

echo
echo "========================================"
echo "ALL CONNECTIVITY TESTS PASSED"
echo "========================================"
