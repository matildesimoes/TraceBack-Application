import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'package:glob/glob.dart';

import 'steps/initial_tests.dart';
import 'steps/auth.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = []
    ..stepDefinitions = [UserIsInInitialPage(), UserIsInInitialPage1(),UserIsInLoginPage(), UserIsInSignUpPage(), TapWidgetOfTypeStep(), UserIsInProfilePage(), WhenFillFieldStep()]
    ..customStepParameterDefinitions = [

    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/app.dart";
  return GherkinRunner().execute(config);
}