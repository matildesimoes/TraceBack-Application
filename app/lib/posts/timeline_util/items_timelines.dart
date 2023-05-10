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
      return LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          color: Colors.white,
          backgroundColor: secondaryColor,
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                SizedBox(height: constraints.maxHeight,),
                SizedBox(
                    height: constraints.maxHeight / 2,
                    child: Center(
                        child:Text("No items were found")
                    )
                ),
              ]
            )
          )
        )
      );
    }
    else {
      return Scrollbar(
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
      );
    }
  }

  Future<void> refresh() async {
    FocusScope.of(context).unfocus();
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
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: secondaryColor,
              color: Colors.white
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