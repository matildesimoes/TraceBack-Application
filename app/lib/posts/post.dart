import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../util/camera.dart';
import 'timeline.dart';

class Post extends StatefulWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  String imageURL;
  late String description;

  Post({Key? key,
    required this.tags,
    required this.title,
    required this.location,
    required this.imageURL,
    required this.description}
      ) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {

  Widget? map;

  Widget? photo;

  @override
  void initState(){
    loadPhoto();
    loadMap();
    super.initState();
  }

  void loadPhoto() async {
    photo = await ImageHandler().getPictureFrame(widget.imageURL);
    setState(() {});
  }

  loadMap() async {
    List<Location> locations;
    try {
      locations = await locationFromAddress(widget.location);
    }on Exception{
      setState(() {
        map = Container(
          height: 30,
          margin: EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: accent
          ),
          child: Center(child: Text("Could not find location named \"${widget.location}\""),
          ),
        );
      });

      return;
    }
    double lat = locations.first.latitude;
    double long = locations.first.longitude;
    LatLng mapLocation = LatLng(lat, long);

    setState(() {
      map = SizedBox(
        height: 250,
        child: ClipRRect(
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
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              child: Scrollbar(
                thickness: 7,
                thumbVisibility: true,
                radius: Radius.circular(10),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                        photo ?? Container(
                            height: 100.0,
                            width: 100.0,
                            margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                            child: CircularProgressIndicator(color: mainColor,)
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: widget.tags,
                    ),
                    SizedBox(height: 20,),
                    widget.description.isNotEmpty
                        && widget.description != "null" ?
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(widget.description),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: accent
                      ),
                    ) : SizedBox.shrink()
                    ,
                    SizedBox(height: 15,),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.location,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),),
                    ),
                    map ?? SizedBox(
                      height: 250,
                      child: Center(
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
    );
  }
}
