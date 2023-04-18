import 'package:TraceBack/firebase_initializer.dart';
import 'package:TraceBack/posts/found_post/create_found_post.dart';
import 'package:TraceBack/posts/timeline.dart';
import 'package:flutter/material.dart';
import 'authentication/initial.dart';

void main() async {
  await FirebaseInitializer().initializeDefault();
  runApp(TraceBack());
}

class TraceBack extends StatefulWidget {

  TraceBack ({Key? key}) : super(key: key);

  @override
  State<TraceBack> createState() => _TraceBackState();
}

class _TraceBackState extends State<TraceBack> {

  late bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: InitialPage()
    );
  }
}