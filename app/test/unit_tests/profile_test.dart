import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:TraceBack/profile/profile.dart';


class ProfilePageMock extends ProfilePage {

  @override
  State<ProfilePage> createState() => _MockProfilePageState();
}

class _MockProfilePageState extends ProfilePageState {


  @override
  void initState() {}

  @override
  Future<Map<String, dynamic>> getUserData() async {
    return {
      'name': 'nome',
      'email': 'up2021@up.pt',
      'phone': '123456789',
      'photoUrl': ''
    };
  }
}

void main() {
  testWidgets('Find user data widgets', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: ProfilePageMock()),
    );

    await tester.pumpAndSettle();

    expect(find.text('nome'), findsOneWidget);
    expect(find.text('up2021@up.pt'), findsOneWidget);
    expect(find.text('123456789'), findsOneWidget);
  });
}
