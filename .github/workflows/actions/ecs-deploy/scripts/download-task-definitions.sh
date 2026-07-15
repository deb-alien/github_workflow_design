#!/usr/bin/env bash

set -euo pipefail

TASK_FAMILY="$1"

aws ecs describe-task-definition \
    --task-definition "$TASK_FAMILY" \
    --query taskDefinition \
    --output json
