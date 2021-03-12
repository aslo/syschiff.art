#!/bin/bash

set -e 
set -x 

DIR=$(dirname "$0")

JEKYLL_ENV=production bundle exec jekyll build

aws s3 sync --delete "${DIR}/../_site/" "s3://syschiff.art"

# Default: cache for 5 minutes 
aws s3 cp \
    --metadata-directive REPLACE \
    --cache-control public,max-age=300  \
    --recursive \
    "s3://syschiff.art" "s3://syschiff.art"

# Cache assets for 30 days
aws s3 cp \
    --metadata-directive REPLACE \
    --cache-control public,max-age=259200 \
    --recursive \
    --exclude "*" \
    --include "*.js" \
    --include "*.css" \
    --include "*.jpg" \
    --include "*.jpeg" \
    --include "*.png" \
    "s3://syschiff.art" "s3://syschiff.art"

