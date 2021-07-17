#!/bin/bash

set -e 

if [ -z "$1" ]; then
    echo "Usage: $0 <image.jpg>"
    exit 1
fi

IMG=$1
DIR=$(dirname "$0")
UUID=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)

# Resize and strip image metadata
OUT="${DIR}/../assets/images"
convert "$IMG" -strip -resize 1400 -quality 85 "${OUT}/${UUID}_full.jpg"
convert "$IMG" -strip -resize 300 -quality 85 "${OUT}/${UUID}_thumb.jpg"
convert "$IMG" -strip -resize 300x300^ -quality 85 -gravity Center -extent 300x300 "${OUT}/${UUID}_square.jpg"

# Get image aspect ratio of thumbnail
ASPECT_RATIO=$(convert "${OUT}/${UUID}_thumb.jpg" -format "%[fx:w/h]" info:)

# Add an entry to all_images data file
echo -e "\n${UUID}:\n\tbasename: ${UUID}\n\taspect_ratio: ${ASPECT_RATIO}\n\ttitle: TITLE\n\tmeduim: MEDIUM" >> "${DIR}/../_data/all_images.yaml"