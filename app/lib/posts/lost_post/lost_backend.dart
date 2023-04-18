import 'package:cloud_firestore/cloud_firestore.dart';

class LostBackend{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "Lost Items";

  CollectionReference<Map<String, dynamic>> getCollection(){

    return firestore.collection(collection);
  }

  void addToCollection(Map<String, dynamic> doc) {
    firestore.collection(collection).add(doc);
  }
}