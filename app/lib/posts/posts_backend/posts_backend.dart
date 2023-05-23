import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class PostsBackend {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get collection;

  CollectionReference<Map<String, dynamic>> getCollection(){

    return firestore.collection(collection);
  }

  Future<String> addToCollection(Map<String, dynamic> doc) async {

    doc['closed'] = false;
    var ref = await firestore.collection(collection).add(doc);
    return ref.id;
  }

  Future<String> upload(File image, String id) async {

    Reference ref = FirebaseStorage.instance
        .ref()
        .child(collection)
        .child('/$id.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': image.path},
    );

    TaskSnapshot task = await ref.putFile(File(image.path), metadata);

    return task.ref.getDownloadURL();
  }

  void addURL(String id, String url) {
    firestore.collection(collection).doc(id).update({"image_url": url});
  }

  Future<DocumentReference<Map<String, dynamic>>> getDoc(String id) async {
    var doc = await firestore.collection(collection).doc(id);

    return doc;
  }

  Future<void> closePost(String postID) async {

    await firestore.collection(collection).doc(postID).update({"closed": true});
  }

  void addItemToUser(String id) async
  {
    User? user = FirebaseAuth.instance.currentUser;

    String col = collection;

    await firestore.collection('Users')
        .doc(user!.uid)
        .collection(collection)
        .add({'id': id});
  }
}

class FoundBackend extends PostsBackend {
  @override
  String get collection => "Found Items";
}

class LostBackend extends PostsBackend {
  @override
  String get collection => "Lost Items";
}