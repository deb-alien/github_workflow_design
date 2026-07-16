#!/usr/bin/env bash

set -euo pipefail

CLUSTER="$1"
SERVICE="$2"
TASK_DEFINITION="$3"

echo "Deployment failed."
echo "Rolling back..."

aws ecs update-service \
    --cluster "$CLUSTER" \
    --service "$SERVICE" \
    --task-definition "$TASK_DEFINITION"

aws ecs wait services-stable \
    --cluster "$CLUSTER" \
    --services "$SERVICE"

echo "Rollback complete."
