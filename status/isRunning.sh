#!/bin/bash
# Check if docker is running
if ! docker info >/dev/null 2>&1; then
     exit 1
fi
echo 1