#!/bin/bash
set -euo pipefail
set -x
cd $(dirname $0)
bundle exec rackup -o 0.0.0.0
exit 0

