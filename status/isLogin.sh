#!/bin/bash
# Check if is login to docker hub registry
docker system info | grep -E 'Username|Registry'