import 'dart:ui';
import 'package:TraceBack/profile/profile.dart';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:TraceBack/profile/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:TraceBack/util/colors.dart';

import '../main_timeline.dart';

class Post extends StatefulWidget {

  late String title;
  late String date;
  List<Tag> tags = [];
  late String location;
  Future<Widget> Function() imageRetriever;
  late String description;
  late String authorID;

  Post({Key? key,
    required this.tags,
    required this.title,
    required this.location,
    required this.imageRetriever,
    required this.date,
    required this.description,
    required this.authorID
  }
      ) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {

  late Widget map;

  Widget? photo;
  Widget? authorPhoto;

  late String authorName;

  @override
  load() async {
    await loadPhoto();
    await loadMap();
    await loadAuthor();
  }

  loadPhoto() async {
    photo = await widget.imageRetriever();
  }

  loadMap() async {
    List<Location> locations;
    try {
      locations = await locationFromAddress(widget.location);
    }on Exception{
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
      return;
    }
    double lat = locations.first.latitude;
    double long = locations.first.longitude;
    LatLng mapLocation = LatLng(lat, long);

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
  }

  loadAuthor() async {

    await ProfileBackend().getName(widget.authorID).then((name) {
      authorName = name;
    });

    String? photoUrl;

    try {
      photoUrl = await ProfileBackend().getPictureURL(widget.authorID);
    } on Exception {
      authorPhoto = SizedBox.shrink();
      return;
    }

    if (photoUrl == null){
      authorPhoto = SizedBox.shrink();
    } else{
      authorPhoto = CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: load(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Expanded(
          child: const Center(
              child: CircularProgressIndicator(
                  backgroundColor: secondaryColor,
                  color: Colors.white
              )
          ),
        );
      }
      else {
        return Expanded(
          child: Scrollbar(
            thickness: 7,
            thumbVisibility: true,
            radius: Radius.circular(10),
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Header(widget: widget, photo: photo),
                SizedBox(height: 10,),
                Wrap(
                  direction: Axis.horizontal,
                  children: widget.tags,
                ),
                SizedBox(height: 30,),
                DescriptionBox(description: widget.description),
                SizedBox(height: 30,),
                LocationDate(location: widget.location, date: widget.date),
                map,
                SizedBox(height: 10,),
                AuthorBox(
                  authorPhoto: authorPhoto,
                  authorName: authorName,
                  authorID: widget.authorID
                ),
                SizedBox(height: 100,)
              ],
            ),
          ),
        );
      }
    }
  );
}

class Header extends StatelessWidget {

  Header({
    super.key,
    required this.widget,
    required this.photo
  });

  final Post widget;
  late Widget? photo;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class LocationDate extends StatelessWidget {
  const LocationDate({
    super.key,
    required this.location,
    required this.date
  });

  final String location;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceBetween,
      children: [
        Text(
          location,
          style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15
          ),
        ),
        Text(
          date,
          style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 15
          ),
        ),
      ],
    );

    /*Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        widget.location,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15),),
    );*/
  }
}

class AuthorBox extends StatelessWidget {

  final Widget? authorPhoto;
  final String authorName;
  final String authorID;

  const AuthorBox({
    super.key,
    required this.authorPhoto,
    required this.authorName,
    required this.authorID
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: accent,
        borderRadius: BorderRadius.circular(50),
        onTap: (){
          if (authorID == ProfileBackend().getCurrentUserID()){
            Navigator.pushNamed(context, "/My Place");
            return;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userID: authorID,
                  )
              )
          );
        },
        child:UnconstrainedBox(
          child: Ink(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: mainColor
            ),
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 12, left: 2),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                authorPhoto ?? SizedBox.shrink(),
                SizedBox(width: 5,),
                Text(authorName,
                  style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
        ),
      );
  }
}

class DescriptionBox extends StatelessWidget {

  final String description;

  const DescriptionBox({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    description.isNotEmpty && description != "null" ?
    Container(
      padding: EdgeInsets.all(10),
      child: Text(description),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: accent
      ),
    )
      :
    SizedBox.shrink();
}

