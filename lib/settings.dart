import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    if (global.apiUrl != 'Insert API URL') {
      global.selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    } else {
      // Restituisci un messaggio informativo se necessario
      print('Settings not fully configured: name: $name, apiUrl: $apiUrl, apikey: $apikey');
    }
  }


  @override
  initState() {
    _readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon:
          const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        Expanded(child:
            const Divider(
              height: 25, //height spacing of divider
            ),
        ),
      Expanded(child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: global.name,

                ),
                controller: nameController,
              ),
            ),
      ),
      Expanded(child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: global.apiUrl,
                ),
                controller: api_url_Controller,
              ),
            ),
      ),
      Expanded(child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: global.apikey,
                ),
                controller: api_Controller,
              ),
            ),
      ),
            const Text('Activate auto update location'),
            /*
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
              onChanged: (value) => setState(() => global.onoff = value),
            ),

             */
            const SizedBox(height: 30),
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
          ],
        ),
      ),
    );
  }
}
