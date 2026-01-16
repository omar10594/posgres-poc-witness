#!/bin/bash
# start-monitor.sh - Start pg_auto_failover monitor using pg_autoctl

set -e

echo "Starting pg_auto_failover monitor..."

# Initialize or start the monitor
if [ ! -f "$PGDATA/postgresql.conf" ]; then
    echo "Creating new monitor instance..."
    
    # Create monitor without running yet
    pg_autoctl create monitor \
        --pgdata "$PGDATA" \
        --pgport 5432 \
        --hostname pg-monitor \
        --auth trust \
        --ssl-self-signed
    
    # Append Tailscale SSL configuration
    echo "Configuring SSL connections for Tailscale access..."
    cat /etc/postgresql/pg_hba_tailscale.conf >> "$PGDATA/pg_hba.conf"
    
    # Now run the monitor
    pg_autoctl run --pgdata "$PGDATA"
else
    echo "Monitor already initialized, starting..."
    pg_autoctl run --pgdata "$PGDATA"
fi

