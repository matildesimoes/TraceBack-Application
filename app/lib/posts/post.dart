import 'dart:ui';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../util/camera.dart';
import 'timeline.dart';

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

  Widget? map;

  Widget? photo;

  @override
  void initState(){
    loadPhoto();
    loadMap();
    super.initState();
  }

  void loadPhoto() async {
    photo = await widget.imageRetriever();
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

    return Expanded(
      flex: 20,
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
            map ?? SizedBox(
              height: 250,
              child: Center(
                child: CircularProgressIndicator(color: mainColor)
              ),
            ),
            SizedBox(height: 10,),
            AuthorBox(id: widget.authorID),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.widget,
    required this.photo,
  });

  final Post widget;
  final Widget? photo;

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
        photo ?? Container(
            height: 100.0,
            width: 100.0,
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
            child: CircularProgressIndicator(color: mainColor,)
        ),
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

class AuthorBox extends StatefulWidget {

  final String id;

  const AuthorBox({
    super.key,
    required this.id
  });

  @override
  State<AuthorBox> createState() => _AuthorBoxState();
}

class _AuthorBoxState extends State<AuthorBox> {

  late String authorName;

  late Widget photo;

  getPhoto() async {

    String? photoUrl;
    
    photoUrl = await ProfileBackend().getPictureURL(widget.id);
    
    if (photoUrl == null){
      photo = SizedBox.shrink();
    } else{
      photo = CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
      );
    }
  }

  getAuthor() async{

    await ProfileBackend().getName(widget.id).then((name) {
      authorName = name;
    });
  }

  init() async {
    await getAuthor();
    await getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){},
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: mainColor
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10)
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                        strokeWidth: 3,
                      )
                    ),
                  ],
                ),
              )
          );
        }else {
          return Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              splashColor: secondaryColor,
              borderRadius: BorderRadius.circular(50),
              onTap: (){},
              child:UnconstrainedBox(
                child: Ink(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: mainColor
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        photo,
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
      },
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

