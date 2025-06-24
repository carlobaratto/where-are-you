# API Position

This API allows you to write and read user locations. You can make HTTP calls to insert new locations (set) and retrieve existing locations (get).

## 🐳 Quick Start with Docker

For the easiest setup, use Docker after updating the configuration of `.env.docker` (APi at `http://localhost:8080`):

```bash
docker compose up -d --build
```

You can also start the API via Symfony at `http://127.0.0.1:8080` via:

```bash
symfony console doctrine:database:create
symfony console doctrine:schema:create

symfony serve
# To stop:
symfony server:stop
```

To generate the OpenAPI specification:
```bash
docker compose up -d --build
docker-compose exec app bin/console api:openapi:export > open-api.json
```


📖 **For detailed Docker instructions, see [README.docker.md](README.docker.md)**
🔒 **For security configuration details, see [README-SECURITY.md](README-SECURITY.md)**

### Environment Variables 

You can configure the application using environment variables in the `.env` file:

| Variable | Description | Default |
|----------|-------------|---------|
| `MAX_MINUTES_TO_KEEP` | Minutes to keep geolocation | `5` |
| `USER_API_KEY` | API key for normal users | `IDDKFA` |
| `ADMIN_API_KEY` | API key for administrators | `LMFAO` |

## Examples of HTTP Calls

### Set

To insert a new location, you can make an HTTP POST call to the following address:
```
http://127.0.0.1:8000/api/positions/register/{group_name}
```

Example of an HTTP call:
```bash
curl -X 'POST' \
  'http://127.0.0.1:8000/api/positions/register/friends' \
  -H 'accept: application/ld+json' \
  -H 'X-AUTH-TOKEN: IDDKFA' \
  -H 'Content-Type: application/ld+json' \
  -d '{
  "position": {
    "name": "Mario",
    "lat": 45.123456,
    "lon": 9.123456
  }
}'
```

### Get

To retrieve existing locations, you can make an HTTP GET call to the following address:
```
http://127.0.0.1:8000/api/positions/{group_name}
```

Example of an HTTP call:
```bash
curl -X 'GET' \
  'http://127.0.0.1:8000/api/positions/friends' \
  -H 'accept: application/ld+json' \
  -H 'X-AUTH-TOKEN: IDDKFA'
```

The response will be a JSON containing the existing locations in the specified group:

```json
{
  "@context": "/api/contexts/Positions",
  "@id": "/api/positions/friends",
  "@type": "Positions",
  "group": "friends",
  "positions": [
    {
      "@type": "PositionRecordResponse",
      "@id": "/api/.well-known/genid/6ac4ee1c03471552fb73",
      "group": "friends",
      "name": "Mario",
      "datetime": "2025-06-21 14:13:28",
      "lat": 45.123456,
      "lon": 9.123456,
      "minutes": 0,
      "color": "green"
    }
  ]
}
```

## Notes

* The user's API key must be valid and correspond to the chosen group.
* Locations are automatically deleted after a certain number of minutes (specified in the `MAX_MINUTES_TO_KEEP` environment variable).
* The response of the get HTTP call also contains a `minutes` field indicating the number of minutes since the user was last seen.