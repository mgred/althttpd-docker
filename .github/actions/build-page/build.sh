#!/usr/bin/env bash

action_dir=`dirname ${BASH_SOURCE[0]}`

pandoc README.md -s -o index.html \
  --metadata pagetitle="althttpd docker" \
  --include-in-header=$action_dir/header.html
