import 'package:TraceBack/posts/my_post_page.dart';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../util/camera.dart';
import 'post_page.dart';
import 'timeline.dart';

class ShortPost extends StatefulWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  late String imageURL;
  late String description;
  late String date;
  late String authorID;
  late String postID;
  late bool isLostPost;
  late bool isClosed;

  ShortPost({super.key, required String tags, required this.title,
    required this.location, required this.imageURL, required this.description,
    required this.date, required this.authorID, required this.postID,
    required this.isLostPost, required this.isClosed
  }){
    if (tags.isNotEmpty)
      for (String tag in tags.split(',')) {
        this.tags.add(Tag(tag));
      }
  }

  @override
  State<ShortPost> createState() => _ShortPostState();
}

class _ShortPostState extends State<ShortPost> {

  Widget? photo;

  void initPhoto() async {

    try {
      photo = await ImageHandler().getPictureFrame(widget.imageURL);
    } catch (e){
      photo = const SizedBox(width: 50,);
    }
    setState(() {});
  }

  @override
  void initState() {
    initPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.authorID == ProfileBackend().getCurrentUserID() && !widget.isClosed){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyPostPage(
                isLostPost: widget.isLostPost,
                postID: widget.postID,
                title: widget.title,
                tags: widget.tags,
                location: widget.location,
                imageURL: widget.imageURL,
                description: widget.description,
                date: widget.date,
                authorID: widget.authorID,
              )));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostPage(
                isClosed: widget.isClosed,
                title: widget.title,
                tags: widget.tags,
                location: widget.location,
                imageURL: widget.imageURL,
                description: widget.description,
                date: widget.date,
                authorID: widget.authorID,
              )));
        }
      },
      child: Container(
        width: double.maxFinite,
        height: 130,
        margin:
        const EdgeInsetsDirectional.only(bottom: 30, start: 20, end: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: accent,
          border: Border.all(style: BorderStyle.solid, color: accent),
        ),
        child: Row(
          children: [
            (widget.imageURL != "null") ?
            photo ?? LoadingPhoto() : SizedBox(width: 40),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: widget.tags,
                        ),
                      ),
                      Expanded(
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        widget.location,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: mainColor),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          )
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}