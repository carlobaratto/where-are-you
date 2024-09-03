import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:where_are_you/settings.dart';
import 'globals.dart' as global;
import 'package:latlong2/latlong.dart' as latLng;
import 'dart:async';

const baseUrl = "https://nordicwalkingitalia.it/ws/ws_eventi.php";

class API {
  static Future getPosition() {
    return http.post(
        Uri.parse(global.api_url),
        body: {
          'apikey': global.apikey,
          'getset' : 'get',
        });
  }
}

class allposition extends StatelessWidget {

  @override

  build(context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ENWI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyListScreenPosition(),
    );
  }
}

class MyListScreenPosition extends StatefulWidget {
  const MyListScreenPosition({super.key});
  @override
  createState() => _MyListScreenPositionState();
}

class _MyListScreenPositionState extends State {
  var posizioni = <Posizione>[];

  _getPosizione() {
    API.getPosition().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        posizioni = list.map((model) => Posizione.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _readSettings();
    _getPosizione();
  }

  dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> _readSettings() async {
    final SharedPreferences prefs = await _prefs;
    String name = prefs.getString('name').toString();
    String api_url = prefs.getString('api_url').toString();
    String apikey = prefs.getString('apikey').toString();

    if (name == '')
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => settings()),
        );
      }
    setState(() {
      global.name = name;
      global.api_url = api_url;
      global.apikey = apikey;
    });
    return name;
  }
  @override

  build(context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
                      options: MapOptions(
                        initialCenter: latLng.LatLng(double.parse(posizioni[0].lat),double.parse(posizioni[0].long)),
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),

                        MarkerLayer(
                          markers: [
                            for (int i=0; i<3; i++)
                            Marker(
                             point: latLng.LatLng(double.parse(posizioni[i].lat),double.parse(posizioni[i].long)),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                              rotate: true,
                            ),
                          ],
                        ),
                        RichAttributionWidget(
                          animationConfig: const ScaleRAWA(), // Or `FadeRAWA` as is default
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ]

          ),
        ],
      ),

    );
  }
}

class Posizione {
  final String name;
  final String datetime;
  final String lat;
  final String long;

  Posizione.fromJson(Map json)
      : name = json['name'],
        datetime = json['datetime'],
        lat = json['lat'],
        long = json['long'];

  Map toJson() {
    return {'name': name, 'datetime': datetime, 'lat':lat, 'long':long};
  }
}