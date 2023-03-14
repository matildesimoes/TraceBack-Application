import 'dart:ui';
import 'package:flutter/material.dart';
import 'main.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          backgroundColor: mainColor,
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35),
              CircleAvatar(
                radius: 70,
                backgroundColor: grey,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Information',
                    style: TextStyle(
                      fontSize: 20,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              EditBox(text: "Name"),
              EditBox(text: 'Email',),
              EditBox(text: "Phone Number"),
            ],
          ),
        ),
      ),
    );
  }
}

class EditBox extends StatelessWidget{

  final String text;
  EditBox({required this.text});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(top: 19),
    padding: EdgeInsets.all(5),
    width: 370,
    decoration: BoxDecoration(
      color: grey,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 17),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(color: mainColor),
            ),
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.edit, color: mainColor),
      ],
    ),
  );
}