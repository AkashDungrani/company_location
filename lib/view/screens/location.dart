import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  double lat = 0.0;
  double long = 0.0;

  Completer<GoogleMapController> mapcontroller = Completer();

  void onMapCreated(GoogleMapController controller) {
    mapcontroller.complete(controller);
    currentMapType = MapType.satellite;
  }

  MapType currentMapType = MapType.normal;

  late CameraPosition aposition;

  liveCoordinates() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        aposition = CameraPosition(
          target: LatLng(lat, long),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    liveCoordinates();
    aposition = CameraPosition(
      target: LatLng(lat, long),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> googlemap =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${googlemap['comapany']}",
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          liveCoordinates();
          setState(() {
            aposition = CameraPosition(
              target: LatLng(googlemap['latitude'], googlemap['longitude']),
              zoom: 20,
            );
          });
          final GoogleMapController controller = await mapcontroller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(aposition));
        },
        label: const Text('Location'),
        icon: const Icon(Icons.gps_fixed_outlined),
      ),
      body: Column(
        children: [
          
          Expanded(
            flex: 12,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapcontroller.complete(controller);
              },
              initialCameraPosition: aposition,
              mapType: currentMapType,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
