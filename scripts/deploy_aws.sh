#!/bin/bash

set -e 

DIR=$(dirname "$0")

JEKYLL_ENV=production bundle exec jekyll build

s3deploy -source $DIR/../_site/ -region us-east-1 -bucket=syschiff.art
