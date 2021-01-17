#!/bin/bash
DONE=./image/data/done.txt
TODO=./image/data/todo.txt
ERROR=./image/data/error.txt

function loadedImages() {
    echo -e "\[33m LOADED IMAGES: (+ YES / - NOT) from File: $TODO"
    for IMAGE in $(cat $TODO)
    do
        IMAGE_CLEANED=${IMAGE//[$'\t\r\n']}
        if [ $(grep -o -i $IMAGE_CLEANED $DONE wc -l) -lt 1]
        then
            echo "$IMAGE_CLEANED" >> $ERROR
            echo -e "\e[31m-$IMAGE_CLEANED"
         else
            echo "$IMAGE_CLEANED" >> $DONE
            echo -e "\e[32m+$IMAGE_CLEANED"
        fi
    done
    echo -e "\e[39m"
}
# Load result of loaded images list to file
#docker images --format "{{.Repository}}" > $DONE
loadedImages