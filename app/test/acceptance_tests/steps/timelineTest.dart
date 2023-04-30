import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

class SideMenuTesting extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final sideMenu = find.text("Home");
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, sideMenu);
    //await FlutterDriverUtils.tap(world.driver, find.text('TraceBack') as SerializableFinder);
    expect(pageExists, true);

  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"I should see the Side Menu");
}