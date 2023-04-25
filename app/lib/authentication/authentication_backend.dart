import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBackend{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,);
    } on FirebaseAuthException catch(e){
      return betterErrorMsg(e.message);
    }
    return "";
  }

  betterErrorMsg(String? message){
    if (message != null){

      switch (message){
        case "Given String is empty or null":
          return "Please fill both fields";

        case "":
          return "something";
      }
    }

    return message;
  }

  Future<String> registerUser(Map<String, dynamic> userDoc) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(
        email: userDoc['email'],
        password: userDoc['password'],
      );

      final user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();

        await saveUserData(userDoc, user.uid);
      }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      }
    }
    return " ";
  }

  Future<void> saveUserData(Map<String, dynamic> userDoc, String userID) async {

    await firestore.collection('Users').doc(userID).set(userDoc);
  }
}