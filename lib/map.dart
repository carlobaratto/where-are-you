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

const baseUrl = "https://carlobaratto.it/whereareyou/api_position.php";

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
  const allposition({super.key});


  @override

  build(context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Where are you',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyListScreenPosition(),
    );
  }
}

class MyListScreenPosition extends StatefulWidget {
  const MyListScreenPosition({super.key});
  @override

  _MyListScreenPositionState createState()=> _MyListScreenPositionState();
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

  @override
  initState() {
    super.initState();
    _getPosizione();
  }

  @override
  dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

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
