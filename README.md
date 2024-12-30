# where_are_you
Each of us has already used apps like Google Maps or WhatsApp to share their location with friends and family. However, not all these apps are designed for respectful sharing of your data and privacy.
WhereAreYou is a free software that allows you to share your location with others without having to pay a fee and keeps the data in your machine thanks to databaseless self hosting.

![alt text](https://blog.carlobaratto.it/wp-content/uploads/2024/12/Schermata-del-2024-12-05-09-30-25.png)
![alt text](https://blog.carlobaratto.it/wp-content/uploads/2024/12/Screenshot_20241229_230914-461x1024.png)
![alt text](https://blog.carlobaratto.it/wp-content/uploads/2024/12/Schermata-del-2024-12-29-23-08-08.png)

## Main Features
**Location sharing:**
you can share your location with friends and family directly from your phone. You can choose whether to share the location at a given time or permanently.
**Control Panel:**
You can view your control panel to control your location and activate/disable sharing.

**Vantage:**
***Security:*** WhereAreYou worry about your security by using advanced encryption technologies to protect your personal information. IMPLEMENTATION
***Money saving:*** You will not have to pay a monthly or annual fee to use our app.
***Easy to use:*** the app is easy to use and requires only a few steps to start sharing your location.

**Advanced features:**

**Self-hosting:**
WhereAreYou is a self-hosted software, which means you can host data on your machine. This guarantees you complete control of your data and prevents the collection of personal data from
 third parties.
**No account needed:**
you don't have to register an account to use WhereAreYou. You can simply download the app and configure the API address to start sharing your location with friends.

## How it works
1. Download and install WhereAreYou on your phone.
2. Configure self-hosted software on your machine, just upload the api_position.php (located at /lib/PHPAPI directory) file taking care to edit the User APIKEY and Admin APIKEY(default is IDDKFA and LMFAO),
3. Set up the app on your mobile phone by entering the API URL, your nickname and the KEY API set first,
4. Start sharing your location with anyone have the API_URL and API_KEY,
5. Use the control panel to control your location and turn on/off sharing.

WhereAreYou is a free and secure software that allows you to share your location with friends and family in real time. You will not have to pay a monthly or annual rate to use the app, and it is easy to use,
requires only a few steps to start sharing your location.

## Development

WhereAreYou is an idea of Kaneda (Carlo Baratto), who takes care of the development helped by Lorenzo Caraffini.
The tests are carried out by the ILS Este group https://este.linux.it/

To contribute or participate in the project, write to whereareyou@carlobaratto.it


## TODO
- Adjust the size of the markers dynamically
- Add settings for the frequency of the map refresh and location update
- Change the marker's color if the location has not been updated within the last 5 minutes
- Create icon

## KNOWN ERRORS
Nothing to report yet

## LICENSE
EUPL