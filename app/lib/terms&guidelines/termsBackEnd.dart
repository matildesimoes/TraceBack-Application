import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TermsBackend{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<void> setUserAcceptedTerms() async {
    await firestore.collection('Users').doc(firebaseAuth.currentUser?.uid).update({'acceptedTerms': true});
  }
}
