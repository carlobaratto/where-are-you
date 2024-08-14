import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'location_page.dart';
import 'package:geolocator/geolocator.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});
  @override
  createState() => _MyMap();
}

class _MyMap extends State {
  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              // initialCenter: latLng,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              /*
              MarkerLayer(
                markers: [
                  Marker(
                    point: latLng!,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                    rotate: true,
                  ),
                ],
              ),

               */
            ],
          ),
        ],
      ),
    );
  }
}