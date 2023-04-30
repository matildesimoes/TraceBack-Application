import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:TraceBack/profile/editprofile.dart';

class EditProfilePageMock extends EditProfilePage  {

  EditProfilePageMock(super.refresh);

  @override
  State<EditProfilePage> createState() => _MockEditProfilePageState();
}

class _MockEditProfilePageState extends EditProfilePageState {

  @override
  void pickUploadImage() {}

  @override
  void captureImage() {}

  @override
  void initState() {

    userData = {
      'name': 'nome',
      'email': 'email',
      'phone': 'phoneNumber',
    };

    setState(() {
      nameController.text = userData['name'];
      emailController.text = userData['email'];
      phoneNumberController.text = userData['phone'];
    });

  }
}

void main() {
  
  testWidgets('Find first EditBox widget', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: EditProfilePageMock((){})));

    await tester.pumpAndSettle();

    expect(find.byType(EditBox), findsNWidgets(3));
  });
}
