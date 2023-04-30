import 'package:TraceBack/firebase_initializer.dart';
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
    nameController.text = "text";
    emailController.text = "email";
    phoneNumberController.text = "phoneNumber";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return super.build(context);
  }
}

void main() {
  
  testWidgets('Find first EditBox widget', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: EditProfilePageMock((){})));


    final editBoxName = find.byType(EditBox);
    final saveButton = find.widgetWithText(ElevatedButton, 'Save');
    await tester.tap(saveButton);
    await tester.pump();

    expect(find.text("text"), findsOneWidget);
    expect(find.text("email"), findsOneWidget);
    expect(find.text("phoneNumber"), findsOneWidget);

  });
}
