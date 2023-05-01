import 'package:TraceBack/firebase_initializer.dart';
import 'package:TraceBack/posts/timeline.dart';
import 'package:TraceBack/profile/my_place.dart';
import 'package:TraceBack/profile/profile.dart';
import 'package:TraceBack/terms&guidelines/guidelines.dart';
import 'package:TraceBack/terms&guidelines/privacyAcceptance.dart';
import 'package:TraceBack/terms&guidelines/privacyInformation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'authentication/initial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer().initializeDefault();
  await FirebaseMessaging.instance.getInitialMessage();
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
      builder: (context, child) => SafeArea(child: child!),
      initialRoute: "/",
      routes: {
        '/' : (context) => InitialPage(),
        '/Home' : (context) => const Timeline(),
        '/My Place': (context) => MyPlace(),
        '/Terms': (context) => Terms(),
        '/Guidelines': (context) => GuidelinesPage(),
        '/AcceptedTerms' :(context) => PrivacyAcceptancePage()
      },
    );
  }
}