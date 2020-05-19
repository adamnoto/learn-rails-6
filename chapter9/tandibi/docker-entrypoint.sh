#!/bin/bash
set -eu

eval "bundle install -j8"
eval "yarn install --check-files"

exec "$@"
