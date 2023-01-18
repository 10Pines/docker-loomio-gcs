#!/bin/bash

set -euo pipefail

version=$1

docker buildx build --build-arg LOOMIO_VERSION="$version" -t ghcr.io/10pines/loomio-gcs:"$version" .
