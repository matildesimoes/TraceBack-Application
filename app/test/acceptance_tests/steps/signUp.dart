import 'package:TraceBack/terms&guidelines/termsBackEnd.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';


class UserIsInInitialPage1 extends GivenWithWorld<FlutterWorld> {
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

class UserIsInSignUpPage extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input) async {
    final initialPage = find.byValueKey(input);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, initialPage);
    //await FlutterDriverUtils.tap(world.driver, find.text('TraceBack') as SerializableFinder);
    expect(pageExists, true);
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I am on the {string}");
}

class EditBoxPage extends And2WithWorld<String, String,FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final word = find.byValueKey(input1);
    await FlutterDriverUtils.enterText(world.driver, word, input2);

  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I fill the {string} field with {string}");
}







