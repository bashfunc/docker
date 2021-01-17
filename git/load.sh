#!/bin/bash
DONE=./git/data/done.txt
TODO=./git/data/todo.txt
ERROR=./git/data/error.txt

function loadGit() {
    echo -e "\[33m LOADED REPOSITORIES: (+ YES / - NOT) from File: $TODO"
    for GIT in $(cat $TODO)
    do
        GIT_CLEANED=${GIT//[$'\t\r\n']}
        if [ $(git clone $GIT_CLEANED) -lt 1]
        then
            echo "$GIT_CLEANED" >> $ERROR
            echo -e "\e[31m-$GIT_CLEANED"
         else
            echo "$GIT_CLEANED" >> $DONE
            echo -e "\e[32m+$GIT_CLEANED"
        fi
    done
    echo -e "\e[39m"
}
# Load result of loaded images list to file
#docker images --format "{{.Repository}}" > $DONE
loadGit