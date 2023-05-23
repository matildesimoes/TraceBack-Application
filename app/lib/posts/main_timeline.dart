import 'dart:ui';
import 'package:TraceBack/authentication/initial.dart';
import 'package:TraceBack/posts/create_post/create_lost_post.dart';
import 'package:TraceBack/posts/timeline_util/category_bar.dart';
import 'package:TraceBack/posts/timeline_util/filter.dart';
import 'package:TraceBack/posts/timeline_util/items_nav_bar.dart';
import 'package:TraceBack/posts/timeline_util/items_timelines.dart';
import 'package:TraceBack/posts/timeline_util/search_bar.dart';
import 'package:flutter/material.dart';
import 'create_post/create_found_post.dart';
import 'package:TraceBack/util/colors.dart';

class MainTimeline extends StatefulWidget {
  const MainTimeline({
    super.key,
  });

  @override
  State<MainTimeline> createState() => _MainTimelineState();
}


class _MainTimelineState extends State<MainTimeline> {

  int _navBarIndex = 0;

  ItemsFilter filter = ItemsFilter();

  late List<ItemsTimeline> timelines;

  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    timelines = [
      FoundTimeline(key: Key("Found Timeline"), filter: filter),
      LostTimeline(key: Key("Lost Timeline"), filter: filter)
    ];
    super.initState();
  }

  search(){
    timelines[_navBarIndex].search();
  }

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
      body: Column(
        children: <Widget>[
          SizedBox(height: 5),
          CategoryBar(
            filter: filter,
            search: search,
            searchCtrl: searchCtrl
          ),
          ItemSearchBar(
            filter: filter,
            search: search,
            controller: searchCtrl,
          ),
          SizedBox(height: 10),
          Expanded(child: timelines[_navBarIndex])
        ],
      ),
      bottomNavigationBar: ItemsNavBar(
        setNavBar: (index){
          setState(() {
            _navBarIndex = index;
          });
      }),
      drawer: SideMenu(),
    );
  }
}

class CreatePostButton extends StatelessWidget {

  late int navBarIndex;

  List<Widget> createPost = [CreateFoundPost(key: Key("Create Found Post")), CreateLostPost(key: Key("Create Lost Post"))];

  CreatePostButton(this.navBarIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox (
      widthFactor: 0.2,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: "Create",
          key: Key("Create"),
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

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Drawer(
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
        FocusScope.of(context).unfocus();
        navigate(context);
      },
      icon: icon,
      label: Text(text, style: TextStyle(color: mainColor),),
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
          heroTag: "GoBack",
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


