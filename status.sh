#!/bin/bash

# Author: Erik Kristensen
# Email: erik@erikkristensen.com
# License: MIT
# Nagios Usage: check_nrpe!check_docker_container!_container_id_
# Usage: ./check_docker_container.sh _container_id_
#
# Edited by: Paulo José de Oliveira Salgado
# Email: paulo@technosoftware.com.br
#
# Depending on your docker configuration, root might be required. If your nrpe user has rights
# to talk to the docker daemon, then root is not required. This is why root privileges are not
# checked.
#
# The script checks if a container is running.
#   OK - running
#   WARNING - restarting
#   CRITICAL - stopped
#   UNKNOWN - does not exist
#
CONTAINER=$1

if [ "x${CONTAINER}" == "x" ]; then
  echo "3" # "UNKNOWN - Container ID or Friendly Name Required"
  exit 3
fi

if [ "x$(which docker)" == "x" ]; then
  echo "3" # "UNKNOWN - Missing docker binary"
  exit 3
fi

docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "3" # "UNKNOWN - Unable to talk to the docker daemon"
  exit 3
fi

RUNNING=$(docker inspect --format="{{.State.Running}}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "3" # "UNKNOWN - $CONTAINER does not exist."
  exit 3
fi

if [ "$RUNNING" == "false" ]; then
  echo "2" # "CRITICAL - $CONTAINER is not running."
  exit 2
fi

RESTARTING=$(docker inspect --format="{{.State.Restarting}}" $CONTAINER)

if [ "$RESTARTING" == "true" ]; then
  echo "1" # "WARNING - $CONTAINER state is restarting."
  exit 1
fi

STARTED=$(docker inspect --format="{{.State.StartedAt}}" $CONTAINER)
NETWORK=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $CONTAINER)

echo "0" # OK - $CONTAINER is running. IP: $NETWORK, StartedAt: $STARTED"