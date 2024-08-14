import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> _insertSettings(name, api_url, apikey) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('name', name);
    prefs.setString('api_url', api_url);
    prefs.setString('apikey', apikey);
    //prefs.clear();
  }

  Future<String> _readSettings() async {
    final SharedPreferences prefs = await _prefs;
    String name = prefs.getString('name').toString();
    String api_url = prefs.getString('api_url').toString();
    String apikey = prefs.getString('apikey').toString();
    if (name=="null")
    {
      name = 'Insert screen name';
    }
    if (api_url=="null")
    {
      api_url = 'Insert API URL';
    }
    if (apikey=="null")
    {
      apikey = 'Insert API KEY';
    }
    setState(() {
      global.name = name;
      global.api_url = api_url;
      global.apikey = apikey;
    });
    return name;
    return api_url;
    return apikey;
  }

  initState() {
    _readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: new IconButton(
          icon:
          new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Divider(
              height: 25, //height spacing of divider
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: global.name,
                ),
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: global.api_url,
                ),
                controller: api_url_Controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: global.apikey,
                ),
                controller: api_Controller,
              ),
            ),
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

