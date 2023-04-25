import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBackend{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<String> login(String email, String password) async {

    UserCredential user;
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,);

      if (!user.user!.emailVerified){
        return "Email not verified";
      }

    } on FirebaseAuthException catch(e){
      return betterErrorMsg(e.code);
    }

    return "";
  }

  betterErrorMsg(String? message){
    if (message != null){

      switch (message){
        case "unknown":
          return "Please fill both fields";

        case "user-not-found":
          return "Email not found";

        case "wrong-password":
          return "Incorrect password";
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
    return "";
  }

  Future<void> saveUserData(Map<String, dynamic> userDoc, String userID) async {

    await firestore.collection('Users').doc(userID).set(userDoc);
  }
}