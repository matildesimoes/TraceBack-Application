import 'package:TraceBack/posts/found_post/found_fake_backend.dart';
import 'package:TraceBack/posts/lost_post/lost_backend.dart';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../posts/short_post.dart';
import '../posts/main_timeline.dart';



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
  void initState() {
    super.isLostPost = true;
    super.initState();
  }

  @override
  getPosts() async {
    List<String> ids = await ProfileBackend().getLostItemsIds();

    for (String id in ids){
      docs.add(await LostBackend().getDoc(id));
    }
  }
}

class MyFoundPosts extends MyPosts {

  const MyFoundPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyFoundPostsState();
}

class _MyFoundPostsState extends _MyPostsState<MyFoundPosts>{

  @override
  void initState() {
    super.isLostPost = false;
    super.initState();
  }

  @override
  getPosts() async {
    docs=[];
    List<String> ids = await ProfileBackend().getFoundItemsIDs();
    for (String id in ids){
      docs.add(await FoundBackend().getDoc(id));
    }
  }
}

abstract class _MyPostsState<T extends MyPosts> extends State<T> {

  List<DocumentSnapshot<Map<String, dynamic>>> docs = [];

  late bool isLostPost;

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
                  Map<String, dynamic>? doc = snapshot.data();
                  if (doc != null) {
                      String title = doc['title'].toString();
                      String tags = doc['tags'].toString();
                      String location = doc['location'].toString();
                      String description = doc['description'].toString();
                      String imageURL = doc['image_url'].toString();
                      String date = doc['date'].toString();
                      String authorID = doc['authorID'].toString();
                      bool isClosed = doc['closed'];

                      PostCard postCard = PostCard(
                        isLostPost: isLostPost,
                        title: title,
                        tags: tags,
                        location: location,
                        description: description,
                        imageURL: imageURL,
                        date: date,
                        authorID: authorID,
                        postID: snapshot.id,
                        isClosed: isClosed,
                      );

                      if (isClosed) {
                        return Stack(
                          children: [
                            postCard,
                            Positioned(
                              top: 0,
                              right: 25,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Closed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return postCard;
                    }
                  }
                ),
            )
          );
        }
      }
    );
  }
}
