import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class profileBackend{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> getuserName() async {
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(user!.displayName).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getUserPhone() async {
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(user!.phoneNumber).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getUserEmail() async {
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(user!.email).get();
    return snapshot.data() as Map<String, dynamic>;
  }
}
