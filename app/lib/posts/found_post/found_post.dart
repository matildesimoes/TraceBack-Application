import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../timeline.dart';

class Found_Post extends StatefulWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  String? imageURL;

  Found_Post({Key? key, required this.tags, required this.title,
    required this.location, this.imageURL}) : super(key: key);

  @override
  State<Found_Post> createState() => _Found_PostState();
}

class _Found_PostState extends State<Found_Post> {

  Widget? map;

  @override
  void initState(){
    loadMap();
    super.initState();
  }
  loadMap() async {
    var addresses = await Geocoder.local.findAddressesFromQuery(widget.location);
    double lat = addresses.first.coordinates.latitude;
    double long = addresses.first.coordinates.longitude;
    LatLng mapLocation = LatLng(lat, long);

    setState(() {
      map = ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AbsorbPointer(
        absorbing: true,
        child: GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.hybrid,

          initialCameraPosition: CameraPosition(
              target: mapLocation,
              zoom: 17.5
          ),
          markers: {
            Marker(
                markerId: const MarkerId("local"),
                infoWindow: InfoWindow(
                    title: widget.location
                ),
                icon: BitmapDescriptor.defaultMarker,
                position: mapLocation
            )}
          ),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          drawer: SideMenu(),
          appBar: AppBar(
            backgroundColor: mainColor,
            toolbarHeight: 80,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  flex: 20,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Title(
                              color: mainColor,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: 100.0,
                            child: ClipOval(
                                child: ImageFiltered(
                                  child: Image(
                                    image: AssetImage("assets/SamsungS10.jpg"),
                                  ),
                                  imageFilter: ImageFilter.blur(
                                      sigmaX: 1.2, sigmaY: 1.2),
                                )
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: widget.tags,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.location,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),),
                      ),
                      SizedBox(
                        height: 250,
                        child: map ??
                            Center(
                                child: CircularProgressIndicator(color: mainColor)
                            ),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            height: 40,
                            width: 110,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<
                                          Color>(mainColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          )
                                      )
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset("assets/profile.jpg"),
                                      ),
                                      Text("Mariana",
                                        style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                )
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 60,
                  width: 200,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.message, color: Colors.white, size: 23,),
                    label: Text("Contact",
                      style: TextStyle(color: Colors.white, fontSize: 17),),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            mainColor),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )
                        )
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
