import 'dart:ui';
import 'package:TraceBack/posts/post.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../util/bottom_button.dart';
import '../util/camera.dart';
import 'found_post/found_fake_backend.dart';
import 'lost_post/lost_backend.dart';
import 'timeline.dart';

class MyPostPage extends StatelessWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  late String imageURL;
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
              date: date, authorID: authorID,),
          ]
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: secondaryColor,
                  onPressed: (){
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
                    });
                  },
                  child: const Icon(size: 25, Icons.close),
                ),
              ),
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                backgroundColor: secondaryColor,
                onPressed: (){
                },
                child: const Icon(size: 25,Icons.edit),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
