#!/bin/bash

# Test script for the golang-junit-agent

set -e

echo "🔨 Building Docker agent..."
cd /Users/goku/bug-tracker/jenkins
docker build -f golang-junit-agent -t golang-junit-agent:latest .

echo ""
echo "✅ Docker agent built successfully!"
echo ""

echo "🧪 Testing the agent..."
echo ""

echo "📋 Available tools:"
docker run --rm golang-junit-agent:latest go version
docker run --rm golang-junit-agent:latest java -version 2>&1 | head -n1
docker run --rm golang-junit-agent:latest mvn -version | head -n1

echo ""
echo "🔍 Testing Go tools:"
docker run --rm golang-junit-agent:latest which golangci-lint
docker run --rm golang-junit-agent:latest which go-junit-report
docker run --rm golang-junit-agent:latest which goimports

echo ""
echo "✅ All tests passed! The Docker agent is ready to use."
echo ""
echo "To use in Jenkins:"
echo "1. Use the fixed 'jenkinsfile' (builds image first)"
echo "2. Or use 'Jenkinsfile-dockerfile' (uses dockerfile agent directly)"
echo ""
echo "To test locally with your project:"
echo "docker run -it --rm -v \$(pwd):/workspace golang-junit-agent:latest"