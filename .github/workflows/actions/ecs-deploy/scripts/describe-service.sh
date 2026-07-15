#!/usr/bin/env bash

set -euo pipefail

CLUSTER="$1"
SERVICE="$2"

aws ecs describe-services \
    --cluster "$CLUSTER" \
    --services "$SERVICE" \
    --query 'services[0].taskDefinition' \
    --output text
