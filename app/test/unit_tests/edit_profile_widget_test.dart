import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:TraceBack/profile/editprofile.dart';

class EditProfilePageMock extends EditProfilePage  {

  EditProfilePageMock(super.refresh, {super.key});

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
      'phone': 'phoneNumber',
    };

    setState(() {
      nameController.text = userData['name'];
      phoneNumberController.text = userData['phone'];
    });

    uid = "RMeHoHaoAEU4YtZjeMv6wxIhHwH2";
  }
}

void main() {
  
  testWidgets('Find first EditBox widget', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: EditProfilePageMock((){})));

    await tester.pumpAndSettle();

    expect(find.byType(EditBox), findsNWidgets(2));

    expect(find.text('nome'), findsOneWidget);
    expect(find.text('phoneNumber'), findsOneWidget);
  });
}
