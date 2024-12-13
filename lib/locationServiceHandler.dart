import 'dart:async';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';



@pragma('vm:entry-point')
void startLocationService() {
  FlutterForegroundTask.setTaskHandler(LocationServiceHandler());
}

class LocationServiceHandler extends TaskHandler {
  Position? _currentPosition;
  Timer? _timer;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _timer = Timer.periodic(const Duration(minutes: 2), (Timer timer) async {
      await _getCurrentPosition();
      if (_currentPosition != null) {
        FlutterForegroundTask.sendDataToMain("${_currentPosition!.latitude.toString()}|${_currentPosition!.longitude.toString()}");
      }
    });
  }

  Future<void> _getCurrentPosition() async {
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

  @override
  void onRepeatEvent(DateTime timestamp) {
    //non usato
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    _timer?.cancel;
  }
}