import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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

  /*Future<void> register() async {

     await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController
    );

    firebaseAuth.currentUser!.sendEmailVerification();

    Map<String, dynamic> doc = {
      'name': ,
      'email': ,
      'phone number': ,
      'password':
    };

    await firestore.collection(collection).add(doc);
  }

  String signIn() {

    try {

    } catch (e){
      return e.toString();
    }
    firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
}*/
}