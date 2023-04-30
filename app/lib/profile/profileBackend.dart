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

  Future<void> addLostItem(String id) async{

    await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Lost Items')
        .add({'id': id});
  }

  Future<List<String>> getLostItemsIds() async {
    var snapshot = await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Lost Items').get();

    List<String> ids = [];

    for (var doc in snapshot.docs){
      ids.add(doc.get('id'));
    }
    return ids;
  }

  Future<void> addFoundItem(String id) async{

    await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Found Items')
        .add({'id': id});
  }

  Future<List<String>> getFoundItemsIDs() async {
    var snapshot = await firestore.collection(collection)
        .doc(user!.uid)
        .collection('Found Items').get();

    List<String> ids = [];

    for (var doc in snapshot.docs){
      ids.add(doc.get('id'));
    }
    return ids;
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


