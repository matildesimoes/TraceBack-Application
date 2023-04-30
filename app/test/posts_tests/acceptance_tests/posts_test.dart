import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'package:glob/glob.dart';

import 'steps/open_post.dart';
import 'steps/timelines.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [
      Glob(r"test/posts_tests/acceptance_tests/features/open_post.feature"),
      Glob(r"test/posts_tests/acceptance_tests/features/timelines.feature")
    ]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..hooks = []
    ..stepDefinitions = [
      UserIsInGivenPage(),
      UserTapsAPost(),
      UserIsInPage(),
      PostCardExists(),
      UserOnlySeesCards(),
      UserTapsNavButton()
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/posts_tests/acceptance_tests/timeline_initializer.dart";
  return GherkinRunner().execute(config);
}
