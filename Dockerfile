# TODO: update to a alpine-based
FROM postgres:16

# Install pg_auto_failover from official repository
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-16-auto-failover \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy PostgreSQL configuration for Tailscale SSL access
COPY config/pg_hba_tailscale.conf /etc/postgresql/pg_hba_tailscale.conf

# Copy startup script
COPY scripts/start-monitor.sh /usr/local/bin/start-monitor.sh
RUN chmod +x /usr/local/bin/start-monitor.sh

# Switch to postgres user for runtime
USER postgres

# Use custom entrypoint
ENTRYPOINT ["/usr/local/bin/start-monitor.sh"]
