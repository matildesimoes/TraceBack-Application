import 'package:TraceBack/posts/timeline_util/filter.dart';
import 'package:TraceBack/posts/timeline_util/post_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../found_post/found_fake_backend.dart';
import '../lost_post/lost_backend.dart';
import '../main_timeline.dart';

abstract class ItemsTimeline extends StatefulWidget {

  final ItemsFilter filter;

  ItemsTimeline({Key? key, required this.filter}) : super(key: key);

  late _ItemsTimelineState state;

  @override
  State<ItemsTimeline> createState();

  search(){
    this.state.search();
  }
}

abstract class _ItemsTimelineState extends State<ItemsTimeline> {

  Future<QuerySnapshot<Map<String, dynamic>>> getSnapshots();

  get isLostPost;

  Widget getPosts(List<PostData> postsData) {

    if(postsData.isEmpty) {
      return Expanded(
          child:LayoutBuilder(
              builder: (context, constraints) => RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: secondaryColor,
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                          height: constraints.maxHeight / 2,
                          child: Center(
                              child:Text("Currently, there are no items to show")
                          )
                      )
                  )
              )
          )
      );
    }
    else {
      return Expanded(
          child: Scrollbar(
              thickness: 7,
              thumbVisibility: true,
              radius: const Radius.circular(10),
              child: RefreshIndicator(
                color: Colors.white,
                backgroundColor: secondaryColor,
                onRefresh: refresh,
                child:ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: postsData.length,
                    itemBuilder: (context, index) {
                      PostData postData = postsData.elementAt(index);
                      return postData.getPostCard();
                    }
                ),
              )
          )
      );
    }
  }

  Future<void> refresh() async {
    widget.filter.setSearchQuery("");
    await getItems();
    setState(() {});
  }

  Future<void> search() async {
    await getItems();
    setState(() {});
  }

  Future<void> getItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshots = await getSnapshots();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshots.docs;
    docs.removeWhere((doc) => doc.get('closed'));
    List<PostData> postsData = [];
    for (var doc in docs) {
      postsData.add(PostData(doc, isLostPost));
    }

    postsData = widget.filter.filterThrough(postsData);
    posts = getPosts(postsData);
  }

  late Widget posts;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Flexible(
            flex: 2,
            child:Center(
              child: CircularProgressIndicator(
                backgroundColor: secondaryColor,
                color: Colors.white
              )
            )
          );
        }
        else {
          return posts;
        }
      },
    );
  }
}

class LostTimeline extends ItemsTimeline{

  LostTimeline({super.key, required super.filter});

  @override
  State<ItemsTimeline> createState() {
    super.state = _LostTimelineState();
    return super.state;
  }
}

class _LostTimelineState extends _ItemsTimelineState {

  @override
  get isLostPost => true;

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getSnapshots() async {
    QuerySnapshot<Map<String, dynamic>> snapshots = await LostBackend().getCollection().get();
    return snapshots;
  }
}

class FoundTimeline extends ItemsTimeline{

  FoundTimeline({super.key, required super.filter});

  @override
  State<ItemsTimeline> createState() {
    super.state = _FoundTimelineState();
    return super.state;
  }
}

class _FoundTimelineState extends _ItemsTimelineState {

  @override
  get isLostPost => false;

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getSnapshots() async {
    var snapshots = await FoundBackend().getCollection().get();
    return snapshots;
  }
}

/*
class LostTimeline extends StatefulWidget {

  const LostTimeline({super.key});

  @override
  State<LostTimeline> createState() => _LostTimeline();
}

class _LostTimeline extends State<LostTimeline> {

  Widget? posts;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> refresh() async {
    var snapshots = await LostBackend().getCollection().get();
    var docs = snapshots.docs;
    docs.removeWhere((doc) => doc.get('closed'));
    setState(() {
      posts = getPosts(docs, refresh, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return posts ?? const Expanded(child:Center(child:
    CircularProgressIndicator(
        backgroundColor: secondaryColor,
        color: Colors.white
    )
    ));
  }
}

Widget getPosts(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    Future<void> Function() refresh, bool isLostPost) {

  if(docs.isEmpty) {
    return Expanded(
        child:LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
                color: Colors.white,
                backgroundColor: secondaryColor,
                onRefresh: refresh,
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                        height: constraints.maxHeight / 2,
                        child: Center(
                            child:Text("Currently, there are no items to show")
                        )
                    )
                )
            )
        )
    );
  }
  else {
    return Expanded(
        child: Scrollbar(
            thickness: 7,
            thumbVisibility: true,
            radius: const Radius.circular(10),
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: secondaryColor,
              onRefresh: refresh,
              child:ListView.builder(
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

                    return PostCard(
                      key: isLostPost ? Key("Lost Post Card") : Key("Found Post Card"),
                      isLostPost: isLostPost,
                      title: title,
                      tags: tags,
                      location: location,
                      description: description,
                      imageURL: imageURL,
                      date: date,
                      authorID: authorID,
                      postID: snapshot.id,
                      isClosed: false,
                    );
                  }
              ),
            )
        )
    );
  }
}*/