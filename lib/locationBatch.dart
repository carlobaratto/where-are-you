import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as global;

class LocationServiceBatch {
  Position? _currentPosition;
  Timer? _timer;

  LocationService() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 2), (Timer timer) async {
      await _getCurrentPosition();
      if (_currentPosition != null) {
        await syncPosition(
          _currentPosition!.latitude.toString(),
          _currentPosition!.longitude.toString(),
        );
      }
    });
  }

  Future<void> syncPosition(String lat, String long) async {
    final response = await http.post(
      Uri.parse(global.apiUrl),
      body: {
        'apikey': global.apikey,
        'getset': 'set',
        'name': global.name,
        'lat': lat,
        'long': long,
      },
    );
    print(response);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled. Please enable the services.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      await _getAddressFromLatLng(_currentPosition!);
    } catch (e) {
      print('Error getting current position: $e');
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      print('Current address: $address');
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  void dispose() {
    _timer?.cancel(); // Cancella il timer quando non è più necessario
  }
}
