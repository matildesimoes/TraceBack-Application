import 'package:TraceBack/profile/profileBackend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../posts/timeline.dart';



abstract class MyPosts extends StatefulWidget {

  const MyPosts({Key? key}) : super(key: key);

  State<MyPosts> createState();
}

class MyLostPosts extends MyPosts {

  const MyLostPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyLostPostsState();
}

class _MyLostPostsState extends _MyPostsState<MyLostPosts>{

  @override
  getPosts() async {
    docs = await ProfileBackend().getLostItems();
  }
}

class MyFoundPosts extends MyPosts {

  const MyFoundPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyFoundPostsState();
}

class _MyFoundPostsState extends _MyPostsState<MyFoundPosts>{

  @override
  getPosts() async {
    docs = await ProfileBackend().getFoundItems();
  }
}

abstract class _MyPostsState<T extends MyPosts> extends State<T> {

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];

  getPosts();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPosts(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: secondaryColor,));
        } else {
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
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var snapshot = docs.elementAt(index);
                      Map<String, dynamic> doc = snapshot.data();
                      String title = doc['title'].toString();
                      String tags = doc['tags'].toString();
                      String location = doc['location'].toString();
                      String description = doc['description'].toString();
                      String imageURL = doc['image_url'].toString();
                      String date = doc['date'].toString();
                      String authorID = doc['authorID'].toString();

                      return ShortPost(title: title, tags: tags,
                        location: location, description: description,
                        imageURL: imageURL, date: date, authorID: authorID,);
                    }
                ),
              )
          );
        }
      }
    );
  }
}
