import 'package:TraceBack/authentication/initial.dart';
import 'package:TraceBack/firebase_initializer.dart';
import 'package:TraceBack/main.dart';
import 'package:TraceBack/posts/timeline.dart';
import 'package:TraceBack/profile/my_place.dart';
import 'package:TraceBack/terms&guidelines/guidelines.dart';
import 'package:TraceBack/terms&guidelines/privacyAcceptance.dart';
import 'package:TraceBack/terms&guidelines/privacyInformation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

class OpenTimeline extends StatefulWidget {
  const OpenTimeline({Key? key}) : super(key: key);

  @override
  State<OpenTimeline> createState() => _OpenTimelineState();
}

class _OpenTimelineState extends State<OpenTimeline> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => SafeArea(child: child!),
      initialRoute: "/Home",
      routes: {
        '/' : (context) => InitialPage(),
        '/Home' : (context) => const Timeline(key: Key("Timeline")),
        '/My Place': (context) => MyPlace(),
        '/Terms': (context) => Terms(),
        '/Guidelines': (context) => GuidelinesPage(),
        '/AcceptedTerms' :(context) => PrivacyAcceptancePage()
      },
    );
  }
}


void main() async {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer().initializeDefault();
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "up202108743@up.pt", password: "Password1!"
  );

  runApp(OpenTimeline());
}