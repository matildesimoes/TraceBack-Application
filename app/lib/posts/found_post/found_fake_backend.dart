import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FoundBackend{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Found Items";

  CollectionReference<Map<String, dynamic>> getCollection(){

    return firestore.collection(collection);
  }

  Future<String> addToCollection(Map<String, dynamic> doc) async {
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
}