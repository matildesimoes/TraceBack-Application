import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class TermsBackend{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<void> setUserAcceptedTerms() async {
    await firestore.collection('Users').doc(firebaseAuth.currentUser?.uid).update({'acceptedTerms': true});
  }

  Future<void> checkAcceptedTerms(BuildContext context) async{
    var snapshot = await firestore.collection('Users').doc(firebaseAuth.currentUser?.uid).get();
    Navigator.of(context).pop();
    bool accepted;
    try {
      accepted = snapshot.get('acceptedTerms');
    }
    catch (e) {
      accepted = false;
    }
    if(!accepted){
      Navigator.of(context).pushNamed("/AcceptedTerms");
    }
    else{
      Navigator.of(context).pushNamed("/Home");
    }
  }
}
