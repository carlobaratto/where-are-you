import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_are_you/locationService.dart';
import 'package:where_are_you/main.dart';
import 'globals.dart' as global;

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<settings> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final nameController = TextEditingController();
  final api_url_Controller = TextEditingController();
  final user_api_Controller = TextEditingController();
  final group_Controller = TextEditingController();

  Future<void> _insertSettings(name, apiUrl, userApikey, group) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('name', name);
    prefs.setString('apiUrl', apiUrl);
    prefs.setString('userApikey', userApikey);
    prefs.setString('group', group);
    //prefs.clear();
  }

  Future<void> _readSettings() async {
    final SharedPreferences prefs = await _prefs;

    // Usa l'operatore null-aware e fornisci un valore di fallback
    String name = prefs.getString('name') ?? '';
    String apiUrl = prefs.getString('apiUrl') ?? '';
    String userApikey = prefs.getString('userApikey') ?? '';
    String group = prefs.getString('group') ?? '';

    setState(() {
      global.name = name;
      global.apiUrl = apiUrl.replaceAll(RegExp(r'/+$'), '');
      global.userApikey = userApikey;
      global.group = group;
    });

    if (global.firsRun == true && global.apiUrl != '') {
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
    group_Controller.text = group;

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
                      labelText: "Group",
                    ),
                    obscureText: true,
                    controller: group_Controller,
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  _insertSettings(nameController.text, api_url_Controller.text, user_api_Controller.text, group_Controller.text);
                  setState(() {
                    _readSettings();
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Settings saved")));
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
