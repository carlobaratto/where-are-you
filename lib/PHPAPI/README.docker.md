# Where Are You - PHP API with Docker

This guide explains how to run the "Where Are You" PHP API using Docker and Docker Compose.

## Prerequisites

- Docker installed on the system
- Docker Compose installed on the system

## Quick Setup

### 1. Environment Variables Preparation

Edit the `.env.docker` file with your configurations:

```bash
APP_ENV=prod
APP_SECRET=

# Maximum number of minutes to keep geolocation
MAX_MINUTES_TO_KEEP=5

# API key for normal users
USER_API_KEY=your_user_key

# API key for administrators
ADMIN_API_KEY=your_admin_key
```

### 2. Starting Services

Build and start the containers:

```bash
docker compose up -d --build
```

The API will be available at `http://localhost:8080` (or on the port specified in `API_PORT`).

## Service Management

### View Logs

```bash
# All logs
docker compose logs -f

# Only API logs
docker compose logs -f phpapi
```

### Stop Services

```bash
docker compose down
```

### Restart Services

```bash
docker compose restart
```

### Update Application

```bash
# Stop services
docker compose down

# Rebuild image
docker compose build --no-cache

# Restart services
docker compose up -d
```

## Available Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `MAX_MINUTES_TO_KEEP` | Minutes to keep geolocation | `5` |
| `USER_API_KEY` | API key for normal users | `IDDKFA` |
| `ADMIN_API_KEY` | API key for administrators | `LMFAO` |

## Data Persistence

The SQLite database is stored in the `./var/` directory which is mounted as a Docker volume. Data will persist even after container restarts.

## Troubleshooting

### API Not Responding

1. Check that containers are running:
   ```bash
   docker compose ps
   ```

2. Check logs for errors:
   ```bash
   docker compose logs phpapi
   ```

### Database Permission Errors

If you encounter SQLite file permission errors:

```bash
# Stop services
docker compose down

# Fix permissions
sudo chown -R $USER:$USER ./var/

# Restart services
docker compose up -d
```

### Modify Configuration

After modifying the `.env.docker` file:

1. Rebuild the docker image:
   ```bash
   docker compose build --no-cache
   ```

2. Restart services:
   ```bash
   docker compose restart
   ```

## Security

- Always change default API keys before using the application in production
- Consider using HTTPS in production
- Limit access to the API port through firewall if necessary