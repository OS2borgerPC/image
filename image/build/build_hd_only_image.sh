#!/bin/bash

DIR=$1; shift

if [ "$DIR" == "" ]; then
    echo "No directory specified"
    exit 1;
fi

DIR=${DIR%/}

FS_IMG="${DIR}/hd_loopback_image.img"

if [ ! -f "$FS_IMG" ]; then
    echo "$FS_IMG does not exist"
    exit 1;
fi

TARGET_DIR=$( mktemp -d "${DIR}/images/os2borgerpc-hd-image.XXXXXXXXXX" )

set -e

TARGET_FILE="${TARGET_DIR}/sda1.ext4-ptcl-img.gz.aa"

echo "Compressing filesystem"
partclone.ext4 -c -s "${FS_IMG}" -O - | gzip > $TARGET_FILE

echo "OS2borgerPC image $TARGET_FILE created"
