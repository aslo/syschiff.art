#!/bin/bash

set -e 

DIR=$(dirname "$0")

JEKYLL_ENV=production bundle exec jekyll build

gsutil -m rsync -r -d "${DIR}/../_site/" "gs://syschiff.art"

# Default: cache for 5 minutes 
gsutil -m setmeta -r -h "Cache-Control: public, max-age=300" "gs://syschiff.art/*"
# Cache the assets directory for 30 days
gsutil -m setmeta -r -h "Cache-Control: public, max-age=2592000" "gs://syschiff.art/assets/*"
