import 'dart:async';

import 'package:TraceBack/posts/create_found_post/create_page.dart';
import 'package:TraceBack/posts/timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class Map extends StatefulWidget {

  late String text;

  Map(this.text, {Key? key}) : super(key: key);

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {

  final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

  Future<LocationData?> loadLocation() async{

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

    LocationData locationData = await location.getLocation();

    if (locationData != null){
      setState(() {
        currentPosition = CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 17.5,
        );
      });
    }
    if (widget.text.isEmpty || selectedMarker == null) {
      _setMarker_(
          currentPosition!.target.latitude, currentPosition!.target.longitude
      );
    }
  }

  static CameraPosition? currentPosition;
  static Marker? selectedMarker;

  @override
  initState(){
    loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    Widget map;
    if (currentPosition != null && selectedMarker != null) {
      map = GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        initialCameraPosition: currentPosition!,
        markers: {selectedMarker!},
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap:(LatLng latlng){
          _setMarker_(latlng.latitude, latlng.longitude);
        },
      );
    }
    else
      map = Center(child: CircularProgressIndicator(color: mainColor,),);

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
            child: map
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

    await loadLocation();

    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition!));
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

    final coordinates = Coordinates(
        selectedMarker!.position.latitude, selectedMarker!.position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;

    return first.addressLine;
  }
}