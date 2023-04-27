import 'dart:ui';
import 'package:TraceBack/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'editprofile.dart';
import '../posts/timeline.dart';
import 'my_posts.dart';

class MyPlace extends StatefulWidget{

  @override
  State<MyPlace> createState() => _MyPlaceState();
}

class _MyPlaceState extends State<MyPlace> {

  int _navBarIndex = 1;

  List<Widget> body = [MyPosts(), ProfilePage(), MyPosts()];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: body[_navBarIndex],
      bottomNavigationBar: Container(
        color: mainColor,
        padding: EdgeInsetsDirectional.symmetric(vertical: 10),
        child: GNav(
          selectedIndex: _navBarIndex,
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

                text: "My Found Posts"
            ),
            GButton(
              icon: Icons.person,
              text: "My Profile",
            ),
            GButton(
                icon: Icons.indeterminate_check_box_rounded,
                text:  "My Lost Posts"
            )
          ],
          onTabChange: (index){
            setState(() {
              _navBarIndex = index;
            });
          },
        ),
      ),
    );
  }
}
