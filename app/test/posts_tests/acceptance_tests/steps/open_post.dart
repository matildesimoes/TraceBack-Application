import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

class UserIsInGivenPage extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {
    final page = find.byValueKey(key);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(pageExists, true);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I am on the {string}");
}

class PostCardExists extends Given1WithWorld<String, FlutterWorld> {

  @override
  Future<void> executeStep(String key) async {
    final post = find.byValueKey(key);
    bool postExists = await FlutterDriverUtils.isPresent(world.driver, post);
    expect(postExists, true);
  }

  @override
  // TODO: implement pattern
  Pattern get pattern => RegExp(r"A {string} exists");
}

class UserTapsAPost extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {
    final post = find.byValueKey(key);
    await FlutterDriverUtils.tap(world.driver, post);
  }

  @override
  // TODO: implement pattern
  Pattern get pattern => RegExp(r"I tap a {string}");
}

class UserIsInPostPage extends Then1WithWorld<String, FlutterWorld> {

  @override
  Future<void> executeStep(String key) async {
    final page = find.byValueKey(key);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(pageExists, true);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I should open a {string}");
}






