import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as global;
import 'package:latlong2/latlong.dart' as latLng;
import 'dart:async';


Future<Position> fetchPosition() async {
  final response = await http.post(
      Uri.parse(global.api_url),
      body: {
        'apikey': global.apikey,
        'getset' : 'get',
      });

  if (response.statusCode == 200) {
final data =Position.fromJson(response.body as Map<String, dynamic>);
return data;
    //return Position.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

  } else {
      throw Exception('Failed to load position');
  }
}

class Position {
  final String name;
  final String datetime;
  final String lat;
  final String long;

  const Position({
    required this.name,
    required this.datetime,
    required this.lat,
    required this.long,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'name': String name,
      'datetime': String datetime,
      'lat': String lat,
      'long': String long,
      } =>
          Position(
            name: name,
            datetime: datetime,
            lat: lat,
            long: long,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  late Future<Position> futurePosition;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> _readSettings() async {
    final SharedPreferences prefs = await _prefs;
    String name = prefs.getString('name').toString();
    String api_url = prefs.getString('api_url').toString();
    String apikey = prefs.getString('apikey').toString();

    setState(() {
      global.name = name;
      global.api_url = api_url;
      global.apikey = apikey;
    });
    return name;
  }
  @override
  void initState() {
    super.initState();
      _readSettings();
    futurePosition = fetchPosition();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [
          FutureBuilder<Position>(
              future: fetchPosition(),
              builder: (context, snapshot)
              {
                if (snapshot.hasData) {
                  return FlutterMap(
                      options: MapOptions(
                        initialCenter: latLng.LatLng(double.parse(snapshot.data!.lat),double.parse(snapshot.data!.long)),
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),

                        MarkerLayer(
                          markers: [
                            Marker(
                              point: latLng.LatLng(double.parse(snapshot.data!.lat),double.parse(snapshot.data!.long))!,

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

                  );
                }
                else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Text("No widget to build");
              }

          ),
        ],
      ),

    );
  }
}

