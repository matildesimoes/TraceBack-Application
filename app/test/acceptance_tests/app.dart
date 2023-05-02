@Tags(['ignore'])

import 'package:TraceBack/firebase_initializer.dart';
import 'package:TraceBack/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer().initializeDefault();
  runApp(TraceBack());
}