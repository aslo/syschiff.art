#!/bin/bash

set -e 

DIR=$(dirname "$0")

JEKYLL_ENV=production bundle exec jekyll build

gsutil -m rsync -r -d "${DIR}/../_site/" "gs://syschiff.art"

# gsutil setmeta -h "Cache-Control: public, max-age=300" gs://my-quick-page/*.html
# gsutil setmeta -h "Cache-Control: public, max-age=31536000" gs://my-quick-page/resources*/**