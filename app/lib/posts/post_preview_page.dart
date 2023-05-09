import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/posts/post.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../notifications/firebaseMessagingService.dart';
import '../util/bottom_button.dart';
import '../util/camera.dart';
import 'lost_post/lost_backend.dart';
import 'timeline.dart';

class PostPreview extends StatelessWidget {

  final FirebaseMessagingService _firebaseMessagingService = FirebaseMessagingService();
  late String title;
  late String category;
  List<Tag> tagWidgets = [];
  late String tags;
  late String location;
  File? image;
  late String description;
  late String date;
  late String authorID;

  Function() submit;

  PostPreview({Key? key,
    required this.tags,
    required this.title,
    required this.location,
    required this.image,
    required this.category,
    required this.date,
    required this.description,
    required this.submit,
    required this.authorID
  }
      ) : super(key: key) {
    if (tags.isNotEmpty) {
      for (String tag in tags.split(',')) {
        this.tagWidgets.add(Tag(tag));
      }
    }
  }



  Future<Widget> imageRetriever() async {
    if (image != null) {
      return Container(
        height: 100.0,
        width: 100.0,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
        child: ClipOval(
            child: FittedBox(
              fit: BoxFit.cover,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 1.3, sigmaY: 1.3),
                child: Image.file(image!),
              ),
            )
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
        leading: BackButton(),
      ),
      body: Column(
          children: [
            Post(tags: tagWidgets, title: title, location: location,
              description: description, imageRetriever: imageRetriever,
              date: date, authorID: authorID,),
          ]
      ),
      floatingActionButton: BottomButton(
        text: "Submit",
        icon: Icons.post_add_rounded,
        onPressed: () async {submit();
        // Construa a mensagem de notificação
        _firebaseMessagingService.sendNotificationToAllUsers('New Found Post', 'A new post has been upload to TraceBack! Check it out to see if it´s yours!');
        Navigator.popUntil(context, ModalRoute.withName("/Home"));}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
