import 'dart:ui';
import 'package:flutter/material.dart';
import 'main.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text("Lost&Found"),
        centerTitle: true,
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Title(
                  color: mainColor,
                  child: Text(
                    "Samsung Galaxy S10+",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: mainColor
                    ),
                  ),
                ),
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
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  IntrinsicWidth(child: Tag("Phone")),
                  IntrinsicWidth(child: Tag("Samsung")),
                  IntrinsicWidth(child: Tag("S10+")),
                ],
              ),
            )
          ],
        ),
      )
    ),
  );
}
