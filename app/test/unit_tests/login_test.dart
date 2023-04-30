import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class LoginPageMock extends StatefulWidget {
  @override
  _LoginPageMockState createState() => _LoginPageMockState();
}

class _LoginPageMockState extends State<LoginPageMock> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController.text = "email";
    passwordController.text = "password";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('Find first EditBox widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPageMock()));

    await tester.pumpAndSettle();

    expect(find.descendant(
      of: find.byType(LoginPageMock),
      matching: find.text('Email'),
    ), findsOneWidget);

    expect(find.descendant(
      of: find.byType(LoginPageMock),
      matching: find.text('Password'),
    ), findsOneWidget);
  });
}
