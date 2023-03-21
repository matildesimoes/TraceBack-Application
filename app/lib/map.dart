import 'dart:async';

import 'package:TraceBack/createFoundPost.dart';
import 'package:TraceBack/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {

  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Future<void> getLocation() async{

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    CurrentPostition = locationData != null
        ? CameraPosition(
      target: LatLng(locationData!.latitude!,
        locationData!.longitude!,),
      zoom: 17.5,
    )
        : const CameraPosition(
      target: LatLng(41.17866515706367, -8.59612434972457),
      zoom: 13,
    );
  }

  LocationData? locationData;

  static CameraPosition CurrentPostition = const CameraPosition(
      target: LatLng(41.17866515706367, -8.59612434972457),
      zoom: 13,
  );

  MapSampleState(){
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).
            push(MaterialPageRoute(builder: (context) => CreateFoundPost()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        initialCameraPosition: CurrentPostition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _addMarker_(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _backToInitial_,
        backgroundColor: mainColor,
        child: const Icon(Icons.center_focus_strong, color: Colors.white,),
      ),
    );
  }

  Future<void> _backToInitial_() async {
    final GoogleMapController controller = await _controller.future;
    await getLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CurrentPostition));
  }

  _addMarker_() {

  }
}