#!/bin/bash

set -e 

if [ -z "$1" ]; then
    echo "Usage: $0 <image.jpg>"
    exit 1
fi

IMG=$1
DIR=$(dirname "$0")
TMP="$DIR/../.tmp"
UUID=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
TMP_IMG="${TMP}/${UUID}.jpg"

mkdir -p "$TMP"

cp "$IMG" "$TMP_IMG"

# Strip image metadata
STRIPPED="${TMP}/${UUID}_stripped.jpg"
convert "$TMP_IMG" -strip $STRIPPED

# Resize
OUT="${DIR}/../assets/images"
convert "$STRIPPED" -resize 1400 -quality 85 "${OUT}/${UUID}_full.jpg"
convert "$STRIPPED" -resize 300 -quality 85 "${OUT}/${UUID}_thumb.jpg"
convert "$STRIPPED" -resize 300x300^ -quality 85 -gravity Center -extent 300x300 "${OUT}/${UUID}_square.jpg"

# Get image aspect ratio of thumbnail
ASPECT_RATIO=$(convert "${OUT}/${UUID}_thumb.jpg" -format "%[fx:w/h]" info:)

# Add an entry to all_images data file
echo "${UUID},${ASPECT_RATIO}," >> "${DIR}/../_data/all_images.csv"