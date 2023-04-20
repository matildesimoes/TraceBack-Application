import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthBackend{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Users";

  Future<void> login(TextEditingController emailController, TextEditingController passwordController, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,);
      Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      Navigator.pop(context);
      if(e.code == 'user-not-found'){

      }
      else if(e.code == 'wrong-password'){

      }
    }
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