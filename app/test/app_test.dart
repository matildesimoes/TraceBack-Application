import 'dart:async';
import 'package:TraceBack/firebase_initializer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'package:glob/glob.dart';

import 'steps/initial_tests.dart';
import 'steps/signUp.dart';

Future<void> main() async {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test/features/timeline.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = []
    ..stepDefinitions = [UserIsInInitialPage(),WhenFillFieldStep(), UserIsInInitialPage1(),UserIsInLoginPage(), TapWidgetOfTypeStep(), UserIsInProfilePage(), UserIsInSignUpPage()]
    ..customStepParameterDefinitions = [

    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/app.dart";
  return GherkinRunner().execute(config);
}
