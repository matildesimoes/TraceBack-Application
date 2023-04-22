import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../util/camera.dart';
import 'lost_post/lost_backend.dart';
import 'timeline.dart';

class PostPreview extends StatefulWidget {

  late String title;
  late String category;
  List<Tag> tags = [];
  late String location;
  File? image;
  late String description;
  late String date;

  PostPreview({Key? key,
    required String tags,
    required this.title,
    required this.location,
    required this.image,
    required this.category,
    required this.description}
      ) : super(key: key) {
    for (String tag in tags.split(',')) {
      this.tags.add(Tag(tag));
    }
  }
  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {

  Widget? map;

  Widget? photo;

  @override
  void initState(){
    loadPhoto();
    loadMap();
    super.initState();
  }

  loadPhoto() {
    if (widget.image != null) {
      setState(() {
        photo = Container(
          height: 100.0,
          width: 100.0,
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: ClipOval(
              child: FittedBox(
                fit: BoxFit.cover,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1.3, sigmaY: 1.3),
                  child: Image.file(widget.image!),
                ),
              )
          ),
        );
      });
    }
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
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
        leading: BackButton(),
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
                        photo ?? SizedBox.shrink()
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: accent
                      ),
                      child: Text(widget.description),
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
                onPressed: submit,
                icon: Icon(Icons.message, color: Colors.white, size: 23,),
                label: Text("Submit",
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

  submit() {
    LostBackend().addToCollection(
        {
          'title': widget.title,
          'category': widget.category,
          'tags': widget.tags,
          'location': widget.location,
          'date': widget.date,
          'description': widget.description
        }
    );
    Navigator.pop(context);
  }
}
