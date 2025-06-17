# Where Are You - PHP API with Docker

This guide explains how to run the "Where Are You" PHP API using Docker and Docker Compose.

## Prerequisites

- Docker installed on the system
- Docker Compose installed on the system

## Quick Setup

### 1. Environment Variables Preparation

Copy the environment variables example file:

```bash
cp .env.example .env
```

Edit the `.env` file with your configurations:

```bash
# Port to expose the API (default: 8080)
API_PORT=8080

# SQLite database file path (relative to container)
DB_FILE=./data/db.sqlite

# Maximum number of minutes to keep geolocation
MAX_MINUTES_TO_KEEP=5

# API key for normal users
USER_API_KEY=your_user_key

# API key for administrators
ADMIN_API_KEY=your_admin_key
```

### 2. PHP Configuration File Generation

Run the script to generate the `config.inc.php` file:

```bash
./generate-config.sh
```

This script will read variables from the `.env` file and automatically create the `config.inc.php` file needed by the PHP application.

### 3. Starting Services

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

## File Structure

```
lib/PHPAPI/
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Service orchestration
├── .env.example            # Environment variables template
├── .env                    # Environment variables (to be created)
├── composer.json           # PHP dependencies
├── generate-config.sh      # Script to generate config.inc.php
├── config.inc.php          # PHP configuration file (generated)
├── data/                   # Directory for SQLite database
│   └── db.sqlite          # SQLite database (created automatically)
├── api_position.php        # Main API
├── .htaccess               # Apache security configuration
├── README.md               # Main documentation
├── README-it.md            # Italian documentation
├── README.docker.md        # Docker documentation (English)
├── README.docker-it.md     # Docker documentation (Italian)
└── private/                # Protected files and utilities
    ├── .gitignore          # Git ignore rules
    ├── config.sample.php   # PHP configuration template
    ├── docker-entrypoint.sh # Docker startup script
    ├── generate-config.sh  # Configuration generation script
    ├── test-docker-setup.sh # Docker setup test script
    ├── test-security.sh    # Security test script
    └── verify-structure.sh # Structure verification script
```

## Available Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `API_PORT` | Port to expose the API | `8080` |
| `DB_FILE` | SQLite database path | `./data/db.sqlite` |
| `MAX_MINUTES_TO_KEEP` | Minutes to keep geolocation | `5` |
| `USER_API_KEY` | API key for normal users | `IDDKFA` |
| `ADMIN_API_KEY` | API key for administrators | `LMFAO` |

## API Testing

Once the services are started, you can test the API:

### Insert a Position (SET)

```bash
curl -X POST \
  http://localhost:8080/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=your_user_key&getset=set&group=Friends&name=Mario&lat=45.123456&lon=9.123456'
```

### Retrieve Positions (GET)

```bash
curl -X POST \
  http://localhost:8080/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=your_user_key&getset=get&group=Friends'
```

## Data Persistence

The SQLite database is stored in the `./data/` directory which is mounted as a Docker volume. Data will persist even after container restarts.

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
sudo chown -R $USER:$USER ./data/

# Restart services
docker compose up -d
```

### Modify Configuration

After modifying the `.env` file:

1. Regenerate the configuration file:
   ```bash
   ./generate-config.sh
   ```

2. Restart services:
   ```bash
   docker compose restart
   ```

## Security

- Always change default API keys before using the application in production
- Consider using HTTPS in production
- Limit access to the API port through firewall if necessary