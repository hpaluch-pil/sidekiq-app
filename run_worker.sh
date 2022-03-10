#!/bin/bash
set -euo pipefail
set -x
cd $(dirname $0)
bundle exec sidekiq -e production -r ./job.rb
exit 0

