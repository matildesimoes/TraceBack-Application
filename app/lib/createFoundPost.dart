import 'package:flutter/material.dart';
import 'main.dart';

class CreateFoundPost extends StatefulWidget {
  const CreateFoundPost({Key? key}) : super(key: key);

  @override
  State<CreateFoundPost> createState() => _CreateFoundPostState();
}

class _CreateFoundPostState extends State<CreateFoundPost> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          centerTitle: true,
          backgroundColor: mainColor,
          toolbarHeight: 80,
        ),
        drawer: SideMenu(),
      ),
    );
  }
}

