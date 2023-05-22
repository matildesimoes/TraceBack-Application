import 'dart:ui';
import 'package:TraceBack/posts/post_pages/post.dart';
import 'package:TraceBack/posts/posts_backend/posts_backend.dart';
import 'package:TraceBack/util/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:TraceBack/util/colors.dart';
import '../../util/camera.dart';
import '../main_timeline.dart';

class MyPostPage extends StatelessWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  late String? imageURL;
  late String description;
  late String date;
  late String authorID;
  late String postID;
  late bool isLostPost;

  MyPostPage({Key? key,
    required this.isLostPost,
    required this.postID,
    required this.tags,
    required this.title,
    required this.location,
    required this.imageURL,
    required this.date,
    required this.description,
    required this.authorID
  }
      ) : super(key: key);

  Future<Widget> imageRetriever() async {
    if (imageURL == null)
      return SizedBox.shrink();
    try {
      return await ImageHandler().getPictureFrame(imageURL!);
    } catch (e){
      return SizedBox.shrink();
    }
  }

  close(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      color: mainColor
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(accent)
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (isLostPost)
                    await LostBackend().closePost(postID);
                  else
                    await FoundBackend().closePost(postID);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(mainColor)
                ),
              ),
            ],
            title:  Text(
              "Are you sure you want \nto close this post?",
              textAlign: TextAlign.center,
            ),
            content: Text("This action can not be reversed."),
          );
        }
      );
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
              date: date, authorID: authorID,),
          ]
      ),
      floatingActionButton: BottomButton(
        text: 'Close',
        onPressed: (){close(context);},
        icon: Icons.close,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
