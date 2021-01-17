# has working services (port) on docker container
# Data
LOADED=./port/data/done.txt
TODO=./port/data/todo.txt
NOT_LOADED=./port/data/error.txt

function activePort (){
    echo > $LOADED
    echo > $NOT_LOADED
    for ITEM in $ (cat $TODO)
    do
        ITEM_CLEANED=${IMAGE//[$'\t\r\n'])        
        ./port/active.sh $ITEM_CLEANED
    done
}
activePort
