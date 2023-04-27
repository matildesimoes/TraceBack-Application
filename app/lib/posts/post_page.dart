import 'dart:ui';
import 'package:TraceBack/posts/post.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../util/bottom_button.dart';
import '../util/camera.dart';
import 'timeline.dart';

class PostPage extends StatelessWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  late String imageURL;
  late String description;
  late String date;

  PostPage({Key? key,
    required this.tags,
    required this.title,
    required this.location,
    required this.imageURL,
    required this.date,
    required this.description}
      ) : super(key: key);

  Future<Widget> imageRetriever() async {
    try {
      return await ImageHandler().getPictureFrame(imageURL);
    } catch (e){
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: Column(
        children: [
          Post(tags: tags, title: title, location: location,
            description: description, imageRetriever: imageRetriever,
            date: date,),
        ]
      ),
      floatingActionButton: BottomButton(
        text: "Contact",
        icon: Icons.message_outlined,
        onPressed: (){}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
