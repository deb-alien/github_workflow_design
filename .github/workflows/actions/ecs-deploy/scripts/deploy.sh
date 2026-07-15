#!/usr/bin/env bash

set -euo pipefail

CLUSTER="$1"
SERVICE="$2"
TASK="$3"

aws ecs update-service \
    --cluster "$CLUSTER" \
    --service "$SERVICE" \
    --task-definition "$TASK" \
    >/dev/null

echo "$TASK"
