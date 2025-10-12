#!/bin/bash

# Build script for golang-junit-agent Docker image

set -e

# Configuration
IMAGE_NAME="golang-junit-agent"
TAG="latest"
DOCKERFILE="golang-junit-agent"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"

# Build the Docker image
docker build -f "${DOCKERFILE}" -t "${IMAGE_NAME}:${TAG}" .

echo "Build completed successfully!"
echo ""
echo "To run the container:"
echo "  docker run -it --rm ${IMAGE_NAME}:${TAG}"
echo ""
echo "To run with volume mount for your workspace:"
echo "  docker run -it --rm -v \$(pwd):/workspace ${IMAGE_NAME}:${TAG}"
echo ""
echo "Available tools in the container:"
echo "  - Go $(docker run --rm ${IMAGE_NAME}:${TAG} go version | cut -d' ' -f3)"
echo "  - Java $(docker run --rm ${IMAGE_NAME}:${TAG} java -version 2>&1 | head -n1 | cut -d'"' -f2)"
echo "  - JUnit Platform Console Standalone"
echo "  - Maven"
echo "  - golangci-lint"
echo "  - go-junit-report"
echo "  - goimports"