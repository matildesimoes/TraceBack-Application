import 'dart:ui';
import 'package:TraceBack/authentication/initial.dart';
import 'package:TraceBack/posts/timeline_util/filter.dart';
import 'package:TraceBack/posts/timeline_util/items_nav_bar.dart';
import 'package:TraceBack/posts/timeline_util/items_timelines.dart';
import 'package:flutter/material.dart';
import 'found_post/create_found_post.dart';
import 'lost_post/create_lost_post.dart';

const Color mainColor = Color(0xFF1a425b);
const Color secondaryColor = Color(0xFFd5a820);
const Color accent = Color(0xFFebebeb);

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
          CategoryBar(
            filter: filter,
            search: search,
            searchCtrl: searchCtrl
          ),
          SearchBar(
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

class CategoryBar extends StatefulWidget {

  ItemsFilter filter;
  Function() search;
  final TextEditingController searchCtrl;

  CategoryBar({
  super.key,
  required this.filter,
  required this.search,
  required this.searchCtrl});

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  filterCategory(String category){
    widget.filter.setCategory(category);
    widget.filter.setSearchQuery("");
    widget.searchCtrl.text = "";
    widget.search();
  }

  updateCategoryIndex(int index){
    setState(() {
      _categoryIndex = index;
    });
  }

  int _categoryIndex = 0;

  List<String> categories = [
    "All", "IT Devices", "Keys", "Clothing", "School Supplies", "Other"
  ];

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
    child: ListView.builder (
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        bool active = index == _categoryIndex;
        return Category(
          categories[index],
          filterCategory: filterCategory,
          index: index,
          active: active,
          updateIndex: updateCategoryIndex,
        );
      },
      itemCount: categories.length,
    )
  );
}

class SearchBar extends StatelessWidget{

  final ItemsFilter filter;
  final Function search;
  final TextEditingController controller;

  SearchBar({
    super.key,
    required this.filter,
    required this.search,
    required this.controller
  });

  @override
  Widget build(BuildContext context) => Container(
    height: 40,
    padding: EdgeInsets.only(right: 30, left: 30),
    child: TextField(
      controller: controller,
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
          onPressed: (){
            filter.setSearchQuery(controller.text);
            search();
          },
        ),
      ),
    )
  );
}

class Category extends StatefulWidget{

  final String text;
  final Function filterCategory;
  final int index;
  final bool active;
  final Function updateIndex;

  const Category(
    this.text, {
      super.key,
      required this.filterCategory,
      required this.index,
      required this.active,
      required this.updateIndex
    }
  );

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
    child: TextButton(
      onPressed: (){
        widget.updateIndex(widget.index);
        widget.filterCategory(widget.text);
      },
      child: Text(
        widget.text,
        style: TextStyle(
            color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            widget.active ? secondaryColor : mainColor
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
            )
        ),
      ),
    ),
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


