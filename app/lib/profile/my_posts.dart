import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../posts/timeline.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 7,
      thumbVisibility: true,
      radius: const Radius.circular(10),
      child: RefreshIndicator(
        color: Colors.white,
        backgroundColor: secondaryColor,
        onRefresh: () async {},
        child:ListView.builder(
          padding: EdgeInsets.all(15),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ShortPost(title: "title", tags: "tags",
              location: "location", description: "description",
              imageURL: "imageURL", date: "date",);
          }
        ),
      )
  );
  }
}
