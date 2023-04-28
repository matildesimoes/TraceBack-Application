 import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileBackend {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;

  String collection = 'Users';

  static Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).update(data);
  }

  Future<void> addLostItem(Map<String, dynamic> doc) async{

    await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Lost Items')
        .add(doc);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getLostItems() async {
    var snapshot = await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Lost Items').get();

    return snapshot.docs;
  }

  Future<void> addFoundItem(Map<String, dynamic> doc) async{

    await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Found Items')
        .add(doc);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getFoundItems() async {
    var snapshot = await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Found Items').get();

    return snapshot.docs;
  }

  String getCurrentUserID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> getName(String userID) async {

    String name = "";

    await firestore.collection(collection).doc(userID).get().then(
            (value) => name = value.get('name'));

    return name;
  }

  Future<String?> getPictureURL(String id) async {

    String? url;

    url = await storage.ref('Profile Pics/$id/ProfilePic.jpg').getDownloadURL();

    return url;
  }
}


