import 'dart:ui';
import 'package:TraceBack/authentication/initial.dart';
import 'package:TraceBack/posts/post.dart';
import 'package:TraceBack/posts/found_post/found_fake_backend.dart';
import 'package:TraceBack/posts/post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../util/camera.dart';
import 'found_post/create_found_post.dart';
import 'lost_post/create_lost_post.dart';
import 'lost_post/lost_backend.dart';
import 'short_post.dart';

const Color mainColor = Color(0xFF1a425b);
const Color secondaryColor = Color(0xFFd5a820);
const Color accent = Color(0xFFebebeb);

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {

  int _navBarIndex = 0;

  List<Widget> timelines = [FoundTimeline(), LostTimeline()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TraceBack"),
        centerTitle: true,
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      floatingActionButton: CreatePostButton(_navBarIndex),
      body: Container(
        child: Column(
          children: <Widget>[
            CategoryBar(),
            SearchBar(),
            timelines[_navBarIndex]
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: mainColor,
        padding: EdgeInsetsDirectional.symmetric(vertical: 10),
        child: GNav(
          iconSize: 30.0,
          gap: 8,
          backgroundColor: mainColor,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          color: Colors.white,
          rippleColor: secondaryColor,
          activeColor: Colors.white,
          tabBackgroundColor: secondaryColor,
          tabs: [
            GButton(
              icon: Icons.check_box_rounded,
              text: "Found Items"
            ),
            GButton(
              icon: Icons.indeterminate_check_box_rounded,
              text: "Lost Items",
            )
          ],
          onTabChange: (index){
            setState(() {
              _navBarIndex = index;
            });
          },
        ),
      ),
      drawer: SideMenu(),
    );
  }
}

class CreatePostButton extends StatelessWidget {

  late int navBarIndex;

  List<Widget> createPost = [CreateFoundPost(), CreateLostPost()];

  CreatePostButton(this.navBarIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox (
      widthFactor: 0.2,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => createPost[navBarIndex])
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {

  final String text;

  const Tag(this.text, {super.key});

  @override
  Widget build(BuildContext context) => IntrinsicWidth(
    child: Container(
        alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
          ),
        margin: const EdgeInsetsDirectional.only(
            top: 10,
            end: 10
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: mainColor,
            border: Border.all(
                style: BorderStyle.solid,
                color: mainColor
            )
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white
          ),
        )
    ),
  );
}

class LoadingPhoto extends StatelessWidget {
  const LoadingPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
      child: CircularProgressIndicator(color: mainColor,)
    );
  }
}

class FoundTimeline extends StatefulWidget {

  @override
  State<FoundTimeline> createState() => _FoundTimelineState();
}

class _FoundTimelineState extends State<FoundTimeline> {

  Widget? posts;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> refresh() async {

    var snapshots = await FoundBackend().getCollection().get();
    var docs = snapshots.docs;
    docs.removeWhere((doc) => doc.get('closed'));
    setState(() {
      posts = getPosts(docs, refresh, true);
    });
  }

  @override
  Widget build(BuildContext context) =>
    posts ?? const Expanded(child:Center(child:
    CircularProgressIndicator(
        backgroundColor: secondaryColor,
        color: Colors.white
    )
    ));
}

class LostTimeline extends StatefulWidget {

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
      posts = getPosts(docs, refresh, false);
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

              return ShortPost(
                isLostPost: isLostPost,
                title: title,
                tags: tags,
                location: location,
                description: description,
                imageURL: imageURL,
                date: date,
                authorID: authorID,
                postID: snapshot.id,
              );
            }
          ),
        )
      )
    );
  }
}

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Drawer(
    width: 180,
    child: Column(
      children: [
        Container(
          height: 110,
          color: mainColor,
          child: Center(
              child:Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 50.0,
              )
          ),
        ),
        SideMenuButton("Home", Icon(Icons.home, color: mainColor)),
        SideMenuButton("My Place", Icon(Icons.account_circle, color: mainColor)),
        SideMenuButton("Terms", Icon(Icons.privacy_tip, color: mainColor)),
        SideMenuButton("Guidelines", Icon(Icons.explicit, color: mainColor)),
        const Spacer(
          flex: 6,
        ),
        Container (
            width: 200,
            height: 60,
            color: mainColor,
            child:TextButton(
                onPressed: (){
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName("/"));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )
            )
        )
      ],
    )
  );
}


class SideMenuButton extends StatelessWidget{

  final Icon icon;

  final String text;

  SideMenuButton(this.text, this.icon);
  
  navigate(BuildContext context){
    switch (text){
      case "Home": {
        Navigator.of(context).popUntil(ModalRoute.withName("/Home"));
        break;
      }
      case "My Place":
        {
          Navigator.of(context).popUntil(ModalRoute.withName("/Home"));
          Navigator.of(context).pushNamed("/$text");
          break;
        }
      case "Chats":
        {
          Navigator.of(context).popUntil(ModalRoute.withName("/Home"));
          Navigator.of(context).pushNamed("/$text");
          break;
        }
      default:
        Navigator.of(context).pushNamed("/$text");
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 200,
    height: 60,
    child: TextButton.icon(
      style: ButtonStyle(
        alignment: Alignment.centerLeft
      ),
      onPressed: () {
        navigate(context);
      },
      icon: icon,
      label: Text(text, style: TextStyle(color: mainColor),),
    )
  );
}

class CategoryBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
    child:ListView (
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        Category("All"),
        Category("IT Devices"),
        Category("Keys"),
        Category("Clothing"),
        Category("School Supplies"),
        Category("Other")
      ],
    )
  );
}

class SearchBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Container(
    height: 70,
    padding: EdgeInsets.only(bottom: 30, right: 30, left: 30),
    child: TextField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
          fontSize: 17
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: accent,
        labelText: "search",
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 2,
                style: BorderStyle.solid
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 1,
                style: BorderStyle.solid
            )
        ),
        suffixIconColor: mainColor,
        suffixIcon: IconButton(
          icon: Icon(Icons.search_outlined,),
          onPressed: (){},
        ),
      ),
    )
  );
}

class Category extends StatelessWidget{

  final String text;

  const Category(this.text, {super.key});

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: (){},
    child: Text(
      text,
      style: TextStyle(color: mainColor),
    )
  );
}

class GoBackButton extends StatelessWidget {
  const GoBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox (
      widthFactor: 0.2,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (){
            Navigator.of(context)
                .push(
                MaterialPageRoute(builder: (context) => InitialPage())
            );
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}


