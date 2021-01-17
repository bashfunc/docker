#!/bin/bash
# Check version of docker
if ! docker info >/dev/null 2>&1; then
     exit 1
fi
docker --version