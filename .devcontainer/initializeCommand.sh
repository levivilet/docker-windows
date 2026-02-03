#!/bin/bash
# Clean up any existing Docker resources
docker system prune --all --force 2>/dev/null || true
