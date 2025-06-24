import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as global;
import 'package:latlong2/latlong.dart' as latLng;
import 'dart:async';
import 'settings.dart';
import 'generated/api.dart';
import 'apiKeyCustomAuth.dart';

class API {
  static Future<PositionsJsonld?> getPosition() {
    final auth = ApiKeyCustomAuth(apiToken: global.userApikey);
    final api_instance = ApiClient(
      basePath: global.apiUrl,
      authentication: auth,
    );
    final positions_api = PositionsApi(api_instance);

    try {
        final result = positions_api.apiPositionsGroupNameGet(global.group);
        print(result);

        return result;
    } catch (e) {
        print('Exception when calling PositionsApi->apiPositionsGroupNameGet: $e\n');
    }

    return (() async {
      return PositionsJsonld();
    })();
  }
}

class AllPosition extends StatelessWidget {
  const AllPosition({super.key});

  @override
  Widget build(BuildContext context) {
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
  _MyListScreenPositionState createState() => _MyListScreenPositionState();
}

class _MyListScreenPositionState extends State<MyListScreenPosition> {
  var posizioni = <PositionRecordResponseJsonld>[];
  Timer? _timer;

  void _checkApiUrlAndRedirect() {
    if (global.apiUrl == "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const settings()),
      );
    } else {
      _getPosizione();

    }
  }

  void _getPosizione() {
    API.getPosition().then((response) {
      if (response != null && response.positions.isNotEmpty) {
        setState(() {
          posizioni = response.positions;
        });
      } else {
        print('Errore: nessuna posizione trovata');
      }
    }).catchError((error) {
      print('Errore di rete: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    _checkApiUrlAndRedirect();
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      _getPosizione();
      print("REFRESHING");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (posizioni.isNotEmpty)
            FlutterMap(
              options: MapOptions(
                initialCenter: latLng.LatLng(
                  double.parse(posizioni[0].lat),
                  double.parse(posizioni[0].lon),
                ),
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    for (var posizione in posizioni)
                      Marker(
                        point: latLng.LatLng(
                          double.parse(posizione.lat),
                          double.parse(posizione.lon),
                        ),
                        width: 100,
                        height: 100,
                        rotate: true,
                        child : Column (
                          children: [
                            Text(
                              posizione.name,
                              style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              )
                            ),
                            Text(
                                '${posizione.minutes} minutes ago',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            if(posizione.color == 'grey')
                            const Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 30,
                            ),
                            if(posizione.color == 'orange')
                              const Icon(
                                Icons.location_on,
                                color: Colors.orange,
                                size: 30,
                              ),
                            if(posizione.color == 'green')
                              const Icon(
                                Icons.location_on,
                                color: Colors.green,
                                size: 30,
                              ),
                          ],
                        )
                      )
                  ],
                ),
                RichAttributionWidget(
                  animationConfig: const ScaleRAWA(),
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () =>
                          launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            )
          else
            const Center(child:
              Text("No location shared yet" )
            ),
          Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                _getPosizione();
                print("REFRESHING FROM BUTTON");
              },
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}
