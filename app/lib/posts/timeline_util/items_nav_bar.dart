import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:TraceBack/util/colors.dart';


class ItemsNavBar extends StatefulWidget {

  ItemsNavBar({Key? key, required this.setNavBar}) : super(key: key);

  @override
  State<ItemsNavBar> createState() => _ItemsNavBarState();

  late Function setNavBar;
}

class _ItemsNavBarState extends State<ItemsNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              key: Key("Found"),
              icon: Icons.check_box_rounded,
              text: "Found Items"
          ),
          GButton(
            key: Key("Lost"),
            icon: Icons.indeterminate_check_box_rounded,
            text: "Lost Items",
          )
        ],
        onTabChange: (index){
          setState(() {
            widget.setNavBar(index);
          });
        },
      ),
    );
  }
}