#!/bin/sh
DIRECTORY=/f/
FILES=/f/docker/data/*.sh
if [[ -d "$DIRECTORY" ]]; then
    echo "$DIRECTORY"
    ls $FILES
else
    exit 1
fi

# -r readable file
# -w writable file
# -x executable file
# -f file
# -h symbolic link
# -s file size greater than zero