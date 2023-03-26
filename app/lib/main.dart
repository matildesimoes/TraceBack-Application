import 'package:TraceBack/posts/timeline.dart';
import 'package:flutter/material.dart';
import 'authentication/initial.dart';

void main() {
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