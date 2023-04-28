import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

class UserIsInInitialPage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final initialPage = find.text("TraceBack");
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, initialPage);
    //await FlutterDriverUtils.tap(world.driver, find.text('TraceBack') as SerializableFinder);
    expect(pageExists, true);

  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I am on the initial page");
}

class UserIsInProfilePage extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input) async {
    final initialPage = find.byValueKey(input);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, initialPage);
    //await FlutterDriverUtils.tap(world.driver, find.text('TraceBack') as SerializableFinder);
    expect(pageExists, true);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I am on the {string} page");
}

class UserIsInLoginPage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input) async {
    final initialPage = find.byValueKey(input);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, initialPage);
    //await FlutterDriverUtils.tap(world.driver, find.text('TraceBack') as SerializableFinder);
    expect(pageExists, true);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I should be navigated to the {string}");
}






