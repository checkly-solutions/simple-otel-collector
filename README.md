# Prometheus Checkly Scraper

Scrapes metrics from Checkly and forwards them to Coralogix.

## Prerequisites

- Docker installed and running

## Environment Variables

Copy `sample.env` to `.env` and fill in your values:

```bash
cp sample.env .env
```

| Variable | Description |
|---|---|
| `CHECKLY_ACCOUNT_ID` | Your Checkly account ID |
| `CHECKLY_PROMETHEUS_BEARER_TOKEN` | Checkly Prometheus API bearer token |
| `CORALOGIX_API_KEY` | Coralogix ingestion API key |

## Setup

### Build the image

```bash
docker build -t prom-scraper-nbc .
```

### Run locally

**Mac / Linux:**

```bash
docker run -d --name prometheus -p 9090:9090 --env-file .env prom-scraper-nbc
```

**Windows (Git Bash):**

```bash
MSYS_NO_PATHCONV=1 docker run -d --name prometheus -p 9090:9090 --env-file .env prom-scraper-nbc
```

**Windows (Command Prompt / PowerShell):**

```cmd
docker run -d --name prometheus -p 9090:9090 --env-file .env prom-scraper-nbc
```

### Deploy to a PaaS (Render, Railway, etc.)

1. Push this repo to GitHub
2. Connect the repo in your PaaS dashboard
3. Set the environment variables (`CHECKLY_ACCOUNT_ID`, `CHECKLY_PROMETHEUS_BEARER_TOKEN`, `CORALOGIX_API_KEY`) in the service settings
4. The platform will auto-detect the Dockerfile and deploy

## Verify It's Working

1. Check container is running:
   ```
   docker ps --filter "name=prometheus"
   ```

2. Check logs:
   ```
   docker logs prometheus --tail 30
   ```

3. Check scrape targets:
   ```
   curl -s http://localhost:9090/api/v1/targets
   ```

4. Query metrics:
   ```
   curl -s "http://localhost:9090/api/v1/query?query=checkly_check_status"
   ```

5. Open Prometheus UI: http://localhost:9090

## Stop / Remove Container

```
docker stop prometheus
docker rm prometheus
```
