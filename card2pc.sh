#!/bin/bash

function image_create_date() {
    exiftool -d '%Y_%m_%d' -p '$createDate' -q "$1"
}
function image_create_timestamp() {
    exiftool -d '%Y%m%d%H%M.%S' -p '$createDate' -q "$1"
}


if [ $# != 2 ]
then
    echo "Copy images from a camera card to destinations organised by shooting date"
    echo "Usage: $0 SRC DEST"
    exit 1
else
    SRC=$1
    DEST=$2
fi

for f in `find $SRC -type f`
do
    date=`image_create_date $f`
    create_timestamp=`image_create_timestamp $f`
    
    if [ ! -d $DEST/$date/ ]
    then
        echo "Creating destination directory $DEST/$date" 
        mkdir -p $DEST/$date
    fi
    cp -upv -t "$DEST/$date/" "$f" 
done 
