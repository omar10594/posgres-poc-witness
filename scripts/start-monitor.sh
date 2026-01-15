#!/bin/bash
# start-monitor.sh - Start pg_auto_failover monitor using pg_autoctl

set -e

echo "Starting pg_auto_failover monitor..."

# Initialize or start the monitor
if [ ! -f "$PGDATA/postgresql.conf" ]; then
    echo "Creating new monitor instance..."
    pg_autoctl create monitor \
        --pgdata "$PGDATA" \
        --pgport 5432 \
        --hostname pg-monitor \
        --auth trust \
        --ssl-self-signed \
        --run
else
    echo "Monitor already initialized, starting..."
    pg_autoctl run --pgdata "$PGDATA"
fi
