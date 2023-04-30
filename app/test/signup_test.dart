import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class SignUpPageMock extends StatefulWidget {
  @override
  _LoginPageMockState createState() => _LoginPageMockState();
}

class _LoginPageMockState extends State<SignUpPageMock> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    nameController.text = "name";
    emailController.text = "email";
    phoneNumberController.text = "number";
    passwordController.text = "password";
    confirmPasswordController.text = "password";
    super.initState();
  }

  @override
  register() async{}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(labelText: 'Password Confirm'),
          ),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('Find first EditBox widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignUpPageMock()));

    await tester.pumpAndSettle();

    expect(find.descendant(
      of: find.byType(SignUpPageMock),
      matching: find.text('Name'),
    ), findsOneWidget);

    expect(find.descendant(
      of: find.byType(SignUpPageMock),
      matching: find.text('Email'),
    ), findsOneWidget);

    expect(find.descendant(
      of: find.byType(SignUpPageMock),
      matching: find.text('Phone Number'),
    ), findsOneWidget);

    expect(find.descendant(
      of: find.byType(SignUpPageMock),
      matching: find.text('Password'),
    ), findsOneWidget);

    expect(find.descendant(
      of: find.byType(SignUpPageMock),
      matching: find.text('Password Confirm'),
    ), findsOneWidget);
  });
}
