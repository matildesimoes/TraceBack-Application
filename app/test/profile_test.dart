import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:TraceBack/profile/profile.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {
  @override
  String get uid => 'user_id';
}

class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot<Map<String, dynamic>> {
  DocumentSnapshotMock(Map<String, dynamic> data) {
    when(this.data()).thenReturn(data);
    when(this.exists).thenReturn(true);
  }
}

void main() {
  late ProfilePage profilePage;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseStorage mockFirebaseStorage;
  late MockFirebaseFirestore mockFirebaseFirestore;

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseStorage = MockFirebaseStorage();
    mockFirebaseFirestore = MockFirebaseFirestore();

    profilePage = ProfilePage();
  });

  testWidgets('ProfilePage - Initial Loading', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: profilePage,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('No data found'), findsOneWidget);
  });

  testWidgets('ProfilePage - User Data Loaded', (WidgetTester tester) async {
    final userData = {
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'phone': '1234567890',
      'photoUrl': 'https://example.com/profile.jpg',
    };

    when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
    when(mockFirebaseFirestore.collection("Users")).thenReturn(MockCollectionReference());
    when(mockFirebaseFirestore.doc("Users")).thenReturn(MockDocumentReference());
    when(mockFirebaseFirestore.doc("Users").get()).thenAnswer((_) async => DocumentSnapshotMock(userData));
    when(mockFirebaseStorage.ref(any)).thenReturn(mockFirebaseStorage as Reference);
    when(mockFirebaseStorage.ref(any).getDownloadURL()).thenAnswer((_) async => 'https://example.com/profile.jpg');

    await tester.pumpWidget(
      MaterialApp(
        home: profilePage,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(userData['name']!), findsOneWidget);
    expect(find.text(userData['email']!), findsOneWidget);
    expect(find.text(userData['phone']!), findsOneWidget);
  });
}
