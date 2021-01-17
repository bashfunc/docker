#!/bin/bash
#echo $1
CONTAINER=$1
DONE="./container-port/data/$CONTAINER/done.txt"
TODO="./container-port/data/$CONTAINER/todo.txt"
ERROR="./container-port/data/$CONTAINER/error.txt"

function activePortsOnContainer() {
    echo -e "\[33m$CONTAINER HAS LOADED PORTS: (+ YES / - NOT) from File: $TODO"
    for PORT in $(cat $REQUIRE)
    do
        PORT_CLEANED=${PORT//[$'\t\r\n']}
        RESULT=$(docker exec -u 0 $CONTAINER bash -c "netstat -tulnp | grep $PORT_CLEANED")        
        if [[ -z "$RESULT" ]];
        then
            echo "$CONTAINER:$PORT_CLEANED" >> $ERROR
            echo -e "\e[31m-$CONTAINER:$PORT_CLEANED"
         else
            echo "$CONTAINER:$PORT_CLEANED" >> $DONE
            echo -e "\e[32m+SCONTAINER:$PORT_CLEANED"
        fi
    done
    echo -e "\e[39m"
}
activePortsOnContainer