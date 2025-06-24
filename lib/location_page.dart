
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as global;
import 'locationService.dart';
import 'locationServiceHandler.dart';
import 'generated/api.dart';
import 'apiKeyCustomAuth.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four']; //TODO Prendere i valori da colonna "group" del db

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

Future<void> syncPosition(String lat, String long) async {
  final auth = ApiKeyCustomAuth(apiToken: global.userApikey);
  final api_instance = ApiClient(
    basePath: global.apiUrl,
    authentication: auth,
  );
  final positions_api = RegisterPositionApi(api_instance);

  try {
    positions_api.apiPositionsregisterGroupNamePost(global.group, 
      RegisterPositionJsonld(
        position: RegisterPositionElementJsonld(
          name: global.name,
          lat: lat,
          lon: long,
        ),
      ));
  } catch (e) {
      print('Exception when calling PositionsApi->apiPositionsGroupNameGet: $e\n');
  }

  final response = await http.post(
    Uri.parse(global.apiUrl),

    body: {
      'apikey': global.userApikey,
      'getset' : 'set',
      'name': global.name,
      'lat': lat,
      'long': long,
      'group': global.group,
    });
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });

  }

  @override
  void initState() {
    super.initState();
    LocationServiceHandler.serviceStoppedStream.listen((_) {
      setState(() {
        global.onoff = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async{
              syncPosition(_currentPosition!.latitude.toString(), _currentPosition!.longitude.toString());
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Location shared one time")));
              },
                child: const Text("Single shot localization"),
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Perpetual sharing started")));
                  } else {
                    LocationService.instance.stop();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Perpetual sharing stopped")));
                  }
                },
              ),
              const SizedBox(height: 30),
              Text('Group selection'), //TODO Spostare il selettori gruppo su mappa
              ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("All location deleted")));
                  },
                  child: DropdownButtonExample(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}