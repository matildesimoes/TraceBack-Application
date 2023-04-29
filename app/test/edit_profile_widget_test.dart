import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:TraceBack/profile/editprofile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  
  testWidgets('Find first EditBox widget', (WidgetTester tester) async {

    final editBoxName = find.byType(EditBox);
    final saveButton = find.widgetWithText(ElevatedButton, 'Save');

    await tester.pumpWidget(MaterialApp(home: EditProfilePage()));
    await tester.enterText(editBoxName, "texto");
    await tester.tap(saveButton);
    await tester.pump();
    
    expect(find.text("texto"), findsWidgets);
  });
}
