#!/usr/bin/env bash

set -xe

action_dir=.github/actions/build-page
build_date=`date +"%d.%m.%Y %H:%M:%S"`
long_sha=`git rev-parse HEAD`
short_sha=${long_sha::10}

docker run --rm \
  --volume $(pwd):/data \
  pandoc/core:latest README.md -s -o index.html \
    --metadata pagetitle="althttpd docker" \
    --include-in-header=$action_dir/header.html \
    --include-before-body=$action_dir/nav.html \
    --include-after-body=$action_dir/footer.html

sed -i \
  "s/@build-date@/${build_date}/ ;
   s/@long-sha@/${long_sha}/ ;
   s/@short-sha@/${short_sha}/" \
  index.html
