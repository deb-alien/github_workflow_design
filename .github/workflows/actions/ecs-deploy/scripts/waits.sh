#!/usr/bin/env bash

set -euo pipefail

CLUSTER="$1"
SERVICE="$2"

aws ecs wait services-stable \
    --cluster "$CLUSTER" \
    --services "$SERVICE"
