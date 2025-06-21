# API Position

This API allows you to write and read user locations. You can make HTTP calls to insert new locations (set) and retrieve existing locations (get).

## 🐳 Quick Start with Docker

For the easiest setup, use Docker after updating the configuration of `.env.docker`:

```bash
# Build
docker compose build --no-cache
# Start
docker compose up -d --build
```

The API will be available at `http://localhost:8080`.

You can also start the API `http://127.0.0.1:8080` via:

```bash
symfony console doctrine:database:create
symfony console doctrine:schema:create

symfony serve
# To stop:
symfony server:stop
```

📖 **For detailed Docker instructions, see [README.docker.md](README.docker.md)**
🔒 **For security configuration details, see [README-SECURITY.md](README-SECURITY.md)**

## Manual Configuration (Traditional Setup)

If you prefer not to use Docker, you need to duplicate the file `private/config.sample.php` and rename it to `config.inc.php`, defining:
 - `$dbFile`: path to the database file (default: ./db.sqlite)
 - `$max_minutes_to_keep`: how many minutes to keep the geolocation saved in the database (default: 5)
 - `$user_api_key`: key to make API calls
 - `$admin_api_key`: key to make special API calls as an administrator

### Environment Variables for Docker

When using Docker, you can configure the application using environment variables in the `.env` file:

| Variable | Description | Default |
|----------|-------------|---------|
| `API_PORT` | Port to expose the API | `8080` |
| `DB_FILE` | SQLite database file path | `./data/db.sqlite` |
| `MAX_MINUTES_TO_KEEP` | Minutes to keep geolocation | `5` |
| `USER_API_KEY` | API key for normal users | `IDDKFA` |
| `ADMIN_API_KEY` | API key for administrators | `LMFAO` |

## Examples of HTTP Calls

### Set

To insert a new location, you can make an HTTP POST call to the following address:
```
http://your-server-address/lib/PHPAPI/api_position.php
```
with the following parameters:

* `apikey`: the user's API key (from `config.inc.php`)
* `getset`: must be set to "set"
* `group`: the chosen user group
* `name`: the user's name
* `lat`: the latitude of the location
* `lon`: the longitude of the location

Example of an HTTP call:
```bash
curl -X POST \
  http://your-server-address/lib/PHPAPI/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=IDDKFA&getset=set&group=Friends&name=Mario&lat=45.123456&lon=9.123456'
```

### Get

To retrieve existing locations, you can make an HTTP POST call to the following address:
```
http://your-server-address/lib/PHPAPI/api_position.php
```
with the following parameters:

* `apikey`: the user's API key (from `config.inc.php`)
* `getset`: must be set to "get"
* `group`: the chosen user group

Example of an HTTP call:
```bash
curl -X POST \
  http://your-server-address/lib/PHPAPI/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=IDDKFA&getset=get&group=Friends'
```
The response will be a JSON containing the existing locations in the specified group:

```json
[
  {
    "id": 4,
    "group": "Friends",
    "name": "Mario",
    "datetime": "2025-01-21 22:33:12",
    "lat": 45.123456,
    "lon": 9.123456,
    "color": "green"
  }
]
```

## Notes

* The user's API key must be valid and correspond to the chosen group.
* Locations are automatically deleted after a certain number of minutes (specified in the `$max_minutes_to_keep` variable in the `config.inc.php` file).
* The response of the get HTTP call also contains a `minutes` field indicating the number of minutes since the user was last seen.