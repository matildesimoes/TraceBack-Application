import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

class UserTapsNavButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {
    final post = find.byValueKey(key);
    await FlutterDriverUtils.tap(world.driver, post);
  }

  @override
  // TODO: implement pattern
  Pattern get pattern => RegExp(r"I tap the {string} on the navigation bar");
}

class UserOnlySeesCards extends And1WithWorld<String, FlutterWorld>{
  @override
  Future<void> executeStep(String key) async {

    final post = find.byValueKey(key);
    bool absent = await FlutterDriverUtils.isAbsent(world.driver, post);
    expect(absent, true);
  }

  @override
  // TODO: implement pattern
  Pattern get pattern => RegExp(r"I should not see {string}s");


}



