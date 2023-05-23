import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/posts/post_pages/post.dart';
import 'package:flutter/material.dart';
import '../../util/bottom_button.dart';
import '../main_timeline.dart';
import 'package:TraceBack/util/colors.dart';

class PostPreview extends StatelessWidget {

  //final FirebaseMessagingService _firebaseMessagingService = FirebaseMessagingService();
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
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure you want to submit?',
                  textAlign: TextAlign.center,),
                  actionsAlignment: MainAxisAlignment.spaceAround,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: mainColor,
                      )
                    ),
                    TextButton(
                      child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: secondaryColor,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        submit();
                        Navigator.popUntil(context, ModalRoute.withName("/Home"));
                      },
                    ),
                  ],
                );
              },
            );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
