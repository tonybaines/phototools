#!/bin/bash
DEST_DIR_FORMAT='%Y_%m_%d'
function image_create_date() {
    exiftool -d $DEST_DIR_FORMAT -p '$createDate' -q "$1"
}


if [ $# != 2 ]
then
    echo "Copy images from a camera card to destinations organised by shooting date"
    echo "Usage: $0 SRC DEST"
    echo "    Images are copied recursively from SRC to DEST/$DEST_DIR_FORMAT"
    exit 1
else
    SRC=$1
    DEST=$2
fi

for f in `find $SRC -type f`
do
    date=`image_create_date $f`
    
    if [ ! -d $DEST/$date/ ]
    then
        echo "Creating destination directory $DEST/$date" 
        mkdir -p $DEST/$date
    fi
    cp -upv -t "$DEST/$date/" "$f" 
done 
