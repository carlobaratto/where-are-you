# WhereAreYou
Each of us has already used apps like Google Maps or WhatsApp to share their location with friends and family. However, not all these apps are designed for respectful sharing of your data and privacy.
WhereAreYou is a free software that allows you to share your location with others without having to pay a fee and keeps the data in your machine thanks to databaseless self hosting.

![Map](https://blog.carlobaratto.it/wp-content/uploads/2025/01/SC1-461x1024.jpg)

![Settings](https://blog.carlobaratto.it/wp-content/uploads/2024/12/Screenshot_20241229_230914-461x1024.png)

![Menu](https://blog.carlobaratto.it/wp-content/uploads/2024/12/Schermata-del-2024-12-29-23-08-08.png)

## Main Features
**Location sharing:**
you can share your location with friends and family directly from your phone. You can choose whether to share the location at a given time or permanently.

**Control Panel:**
You can view your control panel to control your location and activate/disable sharing.

**Advantages:**
- **Security:** WhereAreYou worry about your security by using advanced encryption technologies to protect your personal information.
- **Money saving:** You will not have to pay a monthly or annual fee to use our app.
- **Easy to use:** the app is easy to use and requires only a few steps to start sharing your location.

**Advanced features:**
- **3 visual indicator:**

Green: user seen less than 10 minutes ago,
Orange: user seen between 11 and 60 minutes ago,
Grey: user seen more than 60 minutes ago,
After 120 minutes the marker will disappear.

- **Self-hosting:**
WhereAreYou is a self-hosted software, which means you can host data on your machine. This guarantees you complete control of your data and prevents the collection of personal data from third parties.
- **No account needed:**
you don't have to register an account to use WhereAreYou. You can simply download the app and configure the API address to start sharing your location with friends.

## How it works
1. Download and install **WhereAreYou** on your phone.
2. From the directory `/lib/PHPAPI/`, follow instructions for the setup. User API key should be shared ONLY to people you want to share position with.
3. Upload `/lib/PHPAPI/` on your server.
4. Set up the app on your mobile phone by entering your nickname, API URL and the user API key set. Admin API key is optional.
5. Start sharing your location with anyone have the same API URL and user API key.
6. Use the control panel to control your location and turn on/off sharing.

WhereAreYou is a free and secure software that allows you to share your location with friends and family in real time. You will not have to pay a monthly or annual fee to use the app, and it is easy to use, it requires only a few steps to start sharing your location.

## Development

WhereAreYou is an idea of [Kaneda (Carlo Baratto)](https://github.com/carlobaratto/), who takes care of the development helped by [Lorenzo Caraffini](https://github.com/LorenzoCaraffini).
The tests are carried out by the **[ILS Este Group](https://este.linux.it/)**.

To contribute or participate in the project, write to whereareyou@carlobaratto.it

To update the OpenAPI models:
- Generate the JSON file from `/lib/PHPAPI/`
- Run `npx @openapitools/openapi-generator-cli generate -i PHPAPI/open-api.json -g dart -o generated_full && mv generated_full/lib generated && rm -rf generated_full`

## TODO
- [ ] Adjust the size of the markers dynamically
- [ ] Add settings for the frequency of the map refresh and location update

## KNOWN ISSUES
Nothing to report yet.

## LICENSE
GPL v3.0