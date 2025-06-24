import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'locationServiceHandler.dart';
import 'globals.dart' as global;
import 'package:http/http.dart' as http;
import 'generated/api.dart';
import 'apiKeyCustomAuth.dart';

class LocationService {
  LocationService._();

  static final LocationService instance = LocationService._();

  // ------------- Service API -------------
  Future<void> _requestPlatformPermissions() async {
    final NotificationPermission notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

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

  void init() {
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'location_service',
        channelName: 'Location Service',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<void> start() async {
    await _requestPlatformPermissions();
    bool permissions = await _handleLocationPermission();
    if (!permissions) {
      //TODO: gestisci errore
      return;
    }

    final ServiceRequestResult result = await FlutterForegroundTask.startService(
      notificationTitle: 'Sharing your location...',
      notificationText: 'You are currently sharing your location',
      notificationButtons: [
        NotificationButton(
          id: "stopsharing",
          text: "Stop Sharing",
        )
      ],
      callback: startLocationService,
    );

    if (result is ServiceRequestFailure) {
      throw result.error;
    }
  }

  Future<void> stop() async {
    final ServiceRequestResult result = await FlutterForegroundTask.stopService();
    if (result is ServiceRequestFailure) {
      throw result.error;
    }
  }

  Future<bool> get isRunningService => FlutterForegroundTask.isRunningService;

  // ------------- Service callback -------------

  void _onReceiveTaskData(Object data) {
    if (data is! String) {
      return;
    }

    final location = data.split("|");

    syncPosition(location[0], location[1]);
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
      print('Exception when calling RegisterPositionApi->apiPositionsregisterGroupNamePost: $e\n');
    }
  }
}