#!/usr/bin/env bash

set -euo pipefail

aws ecs register-task-definition \
    --cli-input-json file://"$1" \
    --query 'taskDefinition.taskDefinitionArn' \
    --output text
