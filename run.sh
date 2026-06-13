#!/bin/bash

set -e

COMMAND=$1

case "$COMMAND" in
  build_generator)
    echo "Building generator image..."
    docker build -t generator ./generator
    ;;
  run_generator)
    echo "Running generator container..."
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" generator
    ;;
  create_local_data)
    echo "Creating local data..."
    mkdir -p local_data
    if command -v python3 &>/dev/null; then
      python3 generator/generate.py local_data
    elif command -v python &>/dev/null; then
      python generator/generate.py local_data
    else
      echo "Error: Python not found on the host." >&2
      exit 1
    fi
    ;;
  build_reporter)
    echo "Building reporter image..."
    docker build -t reporter ./reporter
    ;;
  run_reporter)
    echo "Running reporter container..."
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" reporter
    ;;
  structure)
    echo "Project directory structure:"
    if command -v tree &>/dev/null; then
      tree -I "node_modules"
    else
      find . -maxdepth 3 -not -path '*/.*' -not -path '*/node_modules*' | sort | sed -e 's/^[.]//' -e 's/[^/]*\//|-- /g'
    fi
    ;;
  clear_data)
    echo "Clearing generated data..."
    if [ -d "data" ]; then
      rm -rf data/*
      echo "data/ directory cleared."
    else
      echo "data/ directory does not exist."
    fi
    ;;
  inside_generator)
    echo "Checking /data inside generator container:"
    docker run --rm -v "$(pwd)/data:/data" generator ls -la /data
    ;;
  inside_reporter)
    echo "Checking /data inside reporter container:"
    docker run --rm -v "$(pwd)/data:/data" reporter ls -la /data
    ;;
  report_server)
    echo "Starting report web server on http://localhost:8080/report.html..."
    docker run --name report_web_server --rm -p 8080:80 -v "$(pwd)/data:/usr/share/nginx/html:ro" nginx:alpine
    ;;
  *)
    echo "Usage: $0 {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter|report_server}"
    exit 1
    ;;
esac
