import 'dart:async';

import 'package:TraceBack/posts/create_found_post.dart';
import 'package:TraceBack/posts/timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class Map extends StatefulWidget {

  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {

  final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

  Future<LocationData?> getLocation() async{

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location.getLocation();
  }

  static CameraPosition currentPostition = const CameraPosition(
    target: LatLng(41.17866515706367, -8.59612434972457),
    zoom: 13,
  );


  static Marker selectedMarker = Marker(
    markerId: MarkerId("Selected"),
    icon: BitmapDescriptor.defaultMarker
  );

  Map(){
    _init_();
  }

  _init_() async {
    LocationData? locationData;

    await getLocation().then((value) {
      locationData = value;
    });

    if (locationData != null){
      currentPostition = CameraPosition(
        target: LatLng(locationData!.latitude!, locationData!.longitude!),
        zoom: 17.5,
      );
      _setMarker_(locationData!.latitude!, locationData!.longitude!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.hybrid,
              initialCameraPosition: currentPostition,
              markers: {selectedMarker},
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap:(LatLng latlng){
                _setMarker_(latlng.latitude, latlng.longitude);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.pop(context, getAdress());
                },
                backgroundColor: mainColor,
                child: const Icon(Icons.check, color: Colors.white,),
              ),
            )
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: FloatingActionButton(
                  onPressed: _backToInitial_,
                  backgroundColor: mainColor,
                  child: const Icon(Icons.center_focus_strong, color: Colors.white,),
                ),
              )
          )
        ],
      )
    );
  }

  Future<void> _backToInitial_() async {
    final GoogleMapController controller = await _controller.future;

    LocationData? locationData;

    await getLocation().then((value) {
      locationData = value;
    });

    if (locationData != null){
      setState(() {
        currentPostition = CameraPosition(
          target: LatLng(locationData!.latitude!, locationData!.longitude!),
          zoom: 17.5,
        );
      }
      );
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPostition));
  }

  _setMarker_(double lat, double lon) {
    setState(() {
      selectedMarker = Marker(
          markerId: MarkerId("Selected"),
          infoWindow: InfoWindow(title: "Lost Item Location"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(lat, lon)
      );
    });

  }

  Future<String> getAdress() async {

    final coordinates = new Coordinates(
        selectedMarker.position.latitude, selectedMarker.position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;

    return first.addressLine;
  }
}