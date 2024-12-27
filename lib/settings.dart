import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_are_you/locationService.dart';
import 'package:where_are_you/main.dart';
import 'package:where_are_you/map.dart';
import 'globals.dart' as global;

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final nameController = TextEditingController();
  final api_url_Controller = TextEditingController();
  final user_api_Controller = TextEditingController();
  final admin_api_Controller = TextEditingController();

  Future<void> _insertSettings(name, apiUrl, userApikey, adminApikey) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('name', name);
    prefs.setString('apiUrl', apiUrl);
    prefs.setString('userApikey', userApikey);
    prefs.setString('adminApikey', adminApikey);
    //prefs.clear();
  }

  Future<void> _readSettings() async {
    final SharedPreferences prefs = await _prefs;

    // Usa l'operatore null-aware e fornisci un valore di fallback
    String name = prefs.getString('name') ?? 'Insert screen name';
    String apiUrl = prefs.getString('apiUrl') ?? 'Insert API URL';
    String userApikey = prefs.getString('userApikey') ?? 'Insert User API KEY';
    String adminApikey = prefs.getString('adminApikey') ?? 'Insert User API KEY';

    setState(() {
      global.name = name;
      global.apiUrl = apiUrl;
      global.userApikey = userApikey;
      global.adminApikey = adminApikey;
    });

    if (global.firsRun == true && global.apiUrl != 'Insert API URL') {
      global.firsRun = false;
      global.selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }

    nameController.text = name;
    api_url_Controller.text = apiUrl;
    user_api_Controller.text = userApikey;
    admin_api_Controller.text = adminApikey;

  }

  Future<void> isServiceAlreadyUp() async {
    global.onoff = await LocationService.instance.isRunningService;
  }

  @override
  initState() {
    isServiceAlreadyUp();
    _readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Your name",
                    ),
                    controller: nameController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "API URL",
                    ),
                    controller: api_url_Controller,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "User API Key",
                    ),
                    obscureText: true,
                    controller: user_api_Controller,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Admin API Key (if available)",
                    ),
                    obscureText: true,
                    controller: admin_api_Controller,
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  _insertSettings(nameController.text, api_url_Controller.text, user_api_Controller.text, admin_api_Controller.text);
                  setState(() {
                    _readSettings();
                  });
                },
                child: const Text('Save settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
