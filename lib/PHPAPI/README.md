# API Position

Questa API permette di scrivere e leggere le posizioni degli utenti. E' possibile eseguire chiamate HTTP per inserire nuove posizioni (set) e recuperare le posizioni esistenti (get).

## Esempi di chiamate HTTP

### Set

Per inserire una nuova posizione, è possibile eseguire una chiamata HTTP POST al seguente indirizzo:
```
http://indirizzo-tuo-server/lib/PHPAPI/api_position.php
```
con i seguenti parametri:

* `apikey`: la chiave API dell'utente (da `config.inc.php`)
* `getset`: deve essere impostato su "set"
* `group`: il gruppo di appartenenza scelto dell'utente
* `name`: il nome dell'utente
* `lat`: la latitudine della posizione
* `lon`: la longitudine della posizione

Esempio di chiamata HTTP:
```bash
curl -X POST \
  http://indirizzo-tuo-server/lib/PHPAPI/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=IDDKFA&getset=set&group=Amici&name=Mario&lat=45.123456&lon=9.123456'
```
### Get

Per recuperare le posizioni esistenti, è possibile eseguire una chiamata HTTP POST al seguente indirizzo:
```
http://indirizzo-tuo-server/lib/PHPAPI/api_position.php
```
con i seguenti parametri:

* `apikey`: la chiave API dell'utente (da `config.inc.php`)
* `getset`: deve essere impostato su "get"
* `group`: il gruppo di appartenenza scelto dall'utente

Esempio di chiamata HTTP:
```bash
curl -X POST \
  http://indirizzo-tuo-server/lib/PHPAPI/api_position.php \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'apikey=IDDKFA&getset=get&group=Amici'
```
La risposta sarà un JSON contenente le posizioni esistenti nel gruppo specificato:

```json
[
  {
    "id": 4,
    "group": "Amici",
    "name": "Mario",
    "datetime": "2025-01-21 22:33:12",
    "lat": 45.123456,
    "lon": 9.123456,
    "color": "green"
  }
]
```

## Note

* La chiave API dell'utente deve essere valida e corrispondente al gruppo di appartenenza.
* Le posizioni vengono eliminate automaticamente dopo un certo numero di minuti (specificato nella variabile `$max_minutes_to_keep` nel file `config.inc.php`).
* La risposta della chiamata HTTP get contiene anche un campo `minutes` che indica il numero di minuti trascorsi dall'ultima volta che l'utente è stato visto.