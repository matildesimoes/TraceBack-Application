import 'dart:async';

import 'package:TraceBack/posts/found_post/create_found_post.dart';
import 'package:TraceBack/posts/main_timeline.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapBuilder extends StatefulWidget {

  late String text;

  MapBuilder(this.text, {Key? key}) : super(key: key);

  @override
  State<MapBuilder> createState() => MapBuilderState();
}

class MapBuilderState extends State<MapBuilder> {

  final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

  Future<LocationData?> loadLocation() async{

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17.5,
      );
    });
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
          map,
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

  Future<Place> getAdress() async {

    List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedMarker!.position.latitude, selectedMarker!.position.longitude);
    return Place(
        "${placemarks.first.street},${placemarks.first.locality}",
        selectedMarker!.position)
    ;
  }
}

class Place {

  final String address;
  final LatLng latLng;

  Place(this.address, this.latLng);
}