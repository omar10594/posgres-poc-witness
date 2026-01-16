# SoSimple Postgres Monitor

Real-time monitor for PostgreSQL using pg_auto_failover.

## Requirements

- Docker
- Docker Compose

## Setup

1. Create a `.env` file in the project root:
   ```env
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=your_secure_password
   TS_AUTHKEY=your_tailscale_authkey
   ```

2. Create the Docker network:
   ```bash
   docker network create sosimple-network
   ```

## Quick Start

Run the following command:

```bash
docker compose up -d --build
```

Check the status:

```bash
docker compose logs -f pg-monitor
```

## Stop

```bash
docker compose down
```