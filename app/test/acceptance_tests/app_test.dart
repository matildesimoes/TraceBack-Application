@Tags(['ignore'])

import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/initial_tests.dart';
import 'steps/open_post.dart';
import 'steps/signUp.dart';
import 'steps/timelineTest.dart';

Future<void> main() async {
  final config = FlutterTestConfiguration()
    ..features = [
      Glob(r"test/acceptance_tests/features/open_post.feature"),
      Glob(r"test/acceptance_tests/features/timeline.feature"),
      Glob(r"test/acceptance_tests/features/signUp.feature"),
      Glob(r"test/acceptance_tests/features/signUpSecondaryButton.feature"),
      Glob(r"test/acceptance_tests/features/loginSecondaryButton.feature"),
      Glob(r"test/acceptance_tests/features/initial_tests.feature"),
    ]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = []
    ..stepDefinitions = [
      UserIsInInitialPage(),
      WhenFillFieldStep(),
      UserIsInInitialPage1(),
      UserIsInLoginPage(),
      TapWidgetOfTypeStep(),
      UserIsInProfilePage(),
      UserIsInSignUpPage(),
      SideMenuTesting(),
      UserIsInGivenPage(),
      UserTapsAPost(),
      UserIsInPage(),
      PostCardExists(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/acceptance_tests/app.dart";
  return GherkinRunner().execute(config);
}
