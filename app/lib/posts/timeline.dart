import 'dart:ffi';
import 'dart:ui';
import 'package:TraceBack/authentication/initial.dart';
import 'package:TraceBack/authentication/login.dart';
import 'package:TraceBack/posts/post.dart';
import 'package:TraceBack/posts/post_fake_backend.dart';
import 'package:TraceBack/profile/profile.dart';
import 'package:TraceBack/settings/privacy.dart';
import 'package:flutter/material.dart';

import 'create_found_post/create_page.dart';

const Color mainColor = Color(0xFF1D3D5C);
const Color grey = Color(0xFFEBEAEA);

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TraceBack"),
        centerTitle: true,
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      floatingActionButton: CreatePostButton(),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CategoryBar(),
            SearchBar(),
            PostsTimeline()
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          BottomButton(text: "Found"),
          BottomButton(text: "Lost")
        ],
      ),
      drawer: SideMenu(),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox (
      widthFactor: 0.2,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateFoundPost())
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {

  final String text;

  BottomButton({required this.text});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container (
      height: 70,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStatePropertyAll<ContinuousRectangleBorder>(
                ContinuousRectangleBorder()
            ),
            backgroundColor: MaterialStateProperty.all<Color>(mainColor)
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ),
    ),
  );
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

class PostPreview extends StatefulWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  String? imageURL;

  PostPreview({super.key, required String tags, required this.title,
    required this.location, this.imageURL}){

    for (String tag in tags.split(',')) {
      this.tags.add(Tag(tag));
    }
  }

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {

  @override
  void initState() {
    title = widget.title;
    tags = widget.tags;
    location = widget.location;
    imageURL = widget.imageURL;
    super.initState();
  }

  late String title;

  List<Tag> tags = [];

  late String location;

  late String? imageURL;

  @override
  Widget build(BuildContext context) =>
      GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) =>
                  Post(title: title, tags: tags, location: location, imageURL: imageURL))
          );
        },
        child: Container(
          width:  double.maxFinite,
          height: 130,
          margin: const EdgeInsetsDirectional.only(
              bottom: 30,
              start: 20,
              end: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: grey,
              border: Border.all(
                  style: BorderStyle.solid,
                  color: grey
              )
          ),
          child: Row(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: ClipOval(
                    child: imageURL == null ?
                      Container(
                        color: Colors.black12,
                        child: Icon(Icons.photo)
                      )
                        :
                      ImageFiltered(
                        child: Image(
                          image: AssetImage("assets/SamsungS10.jpg"),
                        ),
                        imageFilter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                      )
                ),
              ),
              Expanded (
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            title,
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
                            children: tags,
                          ),
                        ),
                        Expanded (
                            child:Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Row (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView (
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          location,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: mainColor),
                                        ),
                                      ),
                                    ),
                                    /*Text(
                                  "Mariana",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: mainColor),
                                )*/
                                  ],
                                )
                            )
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      );
}

class PostsTimeline extends StatefulWidget {

  @override
  State<PostsTimeline> createState() => _PostsTimelineState();
}

class _PostsTimelineState extends State<PostsTimeline> {

  Future<void> refresh() async {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) =>
      Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {

                  Map<String, Object>? document = FakePostBackend.getDocument(
                      index);
                  if (document == null) {
                    return null;
                  }

                  String title = document['title'].toString();
                  String tags = document['tags'].toString();
                  String location = document['location'].toString();

                  return PostPreview(title: title, tags: tags,
                      location: location);
                }
            ),
          )
      );
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
        SideMenuButton("Home", Icon(Icons.home, color: mainColor), SearchPage()),
        SideMenuButton("Chat", Icon(Icons.chat, color: mainColor), SearchPage()),
        SideMenuButton("Profile", Icon(Icons.account_circle, color: mainColor), ProfilePage()),
        SideMenuButton("Settings", Icon(Icons.settings, color: mainColor), PrivacyPolicyPage()),
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
                      .push(
                      MaterialPageRoute(builder: (context) => InitialPage())
                      );
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

  final StatefulWidget page;

  SideMenuButton(this.text, this.icon, this.page);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 200,
    height: 60,
    child: TextButton.icon(
      style: ButtonStyle(
        alignment: Alignment.centerLeft
      ),
      onPressed: () {
        Navigator.of(context)
            .push(
            MaterialPageRoute(builder: (context) => page)
        );
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
        fillColor: grey,
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
          icon: Icon(Icons.search_rounded),
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
