import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

class UserIsInGivenPage extends Given1WithWorld<String, FlutterWorld> {

  @override
  Future<void> executeStep(String key) async {

    await Future.delayed(Duration(seconds: 5));
    final page = find.byValueKey(key);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(pageExists, true);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the {string}");
}

class PostCardExists extends AndWithWorld<FlutterWorld> {

  @override
  Future<void> executeStep() async {
    final lostPost = find.byValueKey("Post Card");
    bool lostPostExists = await FlutterDriverUtils.isPresent(world.driver, lostPost);

    final foundPost = find.byValueKey("Post Card");
    bool foundPostExists = await FlutterDriverUtils.isPresent(world.driver, foundPost);

    if (!lostPostExists && !foundPostExists) {
      throw Exception("There are no posts available to test");
    }
  }

  @override
  // TODO: implement pattern
  Pattern get pattern => "a Post Card exists";
}

class UserTapsAPost extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {

    final item = find.byValueKey("$key");

    if (await FlutterDriverUtils.isPresent(world.driver, item)) {
      await FlutterDriverUtils.tap(world.driver, item);
    } else {
      throw Exception("Can not click Post Card");
    }
  }

  @override
  // TODO: implement pattern
  Pattern get pattern => RegExp(r"I tap a {string}");
}

class UserIsInPage extends Then1WithWorld<String, FlutterWorld> {

  @override
  Future<void> executeStep(String key) async {
    final page = find.byValueKey(key);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(pageExists, true);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I should be on the {string}");
}






