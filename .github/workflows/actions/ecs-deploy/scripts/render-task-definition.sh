#!/usr/bin/env bash

set -euo pipefail

IMAGE="$1"
CONTAINER="$2"

jq \
    --arg IMAGE "$IMAGE" \
    --arg NAME "$CONTAINER" \
'
del(
    .taskDefinitionArn,
    .revision,
    .status,
    .registeredAt,
    .registeredBy,
    .requiresAttributes,
    .compatibilities
)
|
.containerDefinitions |=
map(
    if .name==$NAME
    then .image=$IMAGE
    else .
    end
)
'
