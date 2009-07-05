#!/bin/bash

function image_create_date() {
    exiftool -d '%Y_%m_%d' -p '$createDate' -q "$1"
}
function image_create_timestamp() {
    exiftool -d '%Y%m%d%H%M.%S' -p '$createDate' -q "$1"
}

SRC=$1
DEST=$2

for f in `find $SRC -type f`
do
    date=`image_create_date $f`
    create_timestamp=`image_create_timestamp $f`
    
    
    echo "Copying: $f to $DEST/$date/"
    
    if [ ! -d $DEST/$date/ ]
    then
        mkdir -p $DEST/$date
    fi
    cp "$f" "$DEST/$date/"
    touch -ct $create_timestamp "$DEST/$date/$filename"
done 
