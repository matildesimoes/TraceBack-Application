import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'package:glob/glob.dart';

import 'steps/initial_tests.dart';
import 'steps/signUp.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test/features/initial_tests.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = []
    ..stepDefinitions = [UserIsInInitialPage(),WhenFillFieldStep(), UserIsInInitialPage1(),UserIsInLoginPage(), TapWidgetOfTypeStep(), UserIsInProfilePage(), UserIsInSignUpPage()]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/timeline_initializer.dart";
  return GherkinRunner().execute(config);
}
