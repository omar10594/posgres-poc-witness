# TODO: update to a alpine-based
FROM postgres:16

# Install pg_auto_failover from official repository
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-16-auto-failover \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Prepare environment as root
RUN mkdir -p /var/lib/postgresql/monitor && \
    chown -R postgres:postgres /var/lib/postgresql && \
    chmod 700 /var/lib/postgresql/monitor

# Configure PATH and PGDATA for postgres user
RUN echo 'export PATH="/usr/lib/postgresql/16/bin:$PATH"' >> /var/lib/postgresql/.bashrc && \
    echo 'export PGDATA="/var/lib/postgresql/monitor"' >> /var/lib/postgresql/.bashrc

# Copy startup script
COPY scripts/start-monitor.sh /usr/local/bin/start-monitor.sh
RUN chmod +x /usr/local/bin/start-monitor.sh && \
    chown postgres:postgres /usr/local/bin/start-monitor.sh

# Switch to postgres user for runtime
USER postgres

# Use custom entrypoint
ENTRYPOINT ["/usr/local/bin/start-monitor.sh"]
