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
  final api_Controller = TextEditingController();
  //final onoff_Controller = TextEditingController();

  Future<void> _insertSettings(name, apiUrl, apikey) async {
    final SharedPreferences prefs = await _prefs;
  //  onoff = onoff as Bool;
    prefs.setString('name', name);
    prefs.setString('apiUrl', apiUrl);
    prefs.setString('apikey', apikey);
   // prefs.setBool('onoff', onoff as bool);
    //prefs.clear();
  }

  Future<void> _readSettings() async {
    final SharedPreferences prefs = await _prefs;

    // Usa l'operatore null-aware e fornisci un valore di fallback
    String name = prefs.getString('name') ?? 'Insert screen name';
    String apiUrl = prefs.getString('apiUrl') ?? 'Insert API URL';
    String apikey = prefs.getString('apikey') ?? 'Insert API KEY';

    setState(() {
      global.name = name;
      global.apiUrl = apiUrl;
      global.apikey = apikey;
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
    api_Controller.text = apikey;

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
                      labelText: "API Key",
                    ),
                    obscureText: true,
                    controller: api_Controller,
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  _insertSettings(nameController.text, api_url_Controller.text, api_Controller.text);
                  setState(() {
                    _readSettings();
                  });
                },
                child: const Text('Save settings'),
              ),

              const SizedBox(height: 30),
              const Text('Activate auto update location'),
              Switch(
                // thumb color (round icon)
                activeColor: Colors.amber,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: global.onoff,
                // changes the state of the switch
                onChanged: (value) {
                  setState(() => global.onoff = value);
                  if (value) {
                    LocationService.instance.start();
                  } else {
                    LocationService.instance.stop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
