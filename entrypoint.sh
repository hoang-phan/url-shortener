#!/bin/bash
set -e

# Remove potentially existing server pid
rm -f /opt/app/tmp/pids/server.pid

exec "$@"