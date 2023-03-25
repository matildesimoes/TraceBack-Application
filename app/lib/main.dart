import 'dart:ffi';
import 'dart:ui';
import 'package:TraceBack/post.dart';
import 'package:flutter/material.dart';

import 'createFoundPost.dart';

const Color mainColor = Color(0xFF1D3D5C);

const Color grey = Color(0xFFEBEAEA);

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {

  MainPage ({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late Bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage()
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

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
  Widget build(BuildContext context) => Container(
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
  );
}


class PostsTimeline extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Expanded(
    child: ListView(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .push(
                MaterialPageRoute(builder: (context) => Post())
              );
            },
            child: _Post1(),
          ),
          _Post2(),
          _Post3(),
          SizedBox(
            height: 90,
          )
        ]
    )
  );

  Widget _Post3() {
    return Container(
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
                child: ImageFiltered(
                  child: Image(
                    image: AssetImage("assets/jacket.jpg"),
                  ),
                  imageFilter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                )
            ),
          ),
          Expanded (
              child: Padding(
                padding: EdgeInsets.only(left: 1, right: 40),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Text(
                        "Brown Jacket",
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
                            children: [
                              Tag("Jacket"),
                              Tag("Brown"),
                              Tag("Zara"),
                              Tag("Old")
                            ],
                          )
                    ),
                    Expanded (
                        child:Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FEUP - Bar de Minas",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
                                ),
    /*Text(
                                  "Alex",
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
    );
  }

  Widget _Post2() {
    return Container(
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
                child: ImageFiltered(
                  child: Image(
                    image: AssetImage("assets/BrokenWatch.jpg"),
                  ),
                  imageFilter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                )
            ),
          ),
          Expanded (
              child: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Text(
                        "Broken Apple Watch",
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
                            children: [
                              Tag("Watch"),
                              Tag("White")
                            ],
                          )
                    ),
                    Expanded (
                        child:Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FDUP - 3.12",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
                                ),
                                /*
                                Text(
                                  "Tiago",
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
    );
  }

  Widget _Post1() {
    return Container(
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
                child: ImageFiltered(
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
                      child: const Text(
                        "Samsung Galaxy S10+",
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
                          children: [
                            Tag("Phone"),
                            Tag("Samsung"),
                            Tag("S10+")
                          ],
                      ),
                    ),
                    Expanded (
                        child:Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FEUP - B203",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
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
        SideMenuButton("Home", Icon(Icons.home, color: mainColor), MainPage()),
        SideMenuButton("Chat", Icon(Icons.chat, color: mainColor), MainPage()),
        SideMenuButton("Profile", Icon(Icons.account_circle, color: mainColor), MainPage()),
        SideMenuButton("Settings", Icon(Icons.settings, color: mainColor), MainPage()),
        const Spacer(
          flex: 6,
        ),
        Container (
            width: 200,
            height: 60,
            color: mainColor,
            child:TextButton(
                onPressed: (){},
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