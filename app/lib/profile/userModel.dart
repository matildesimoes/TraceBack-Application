import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final String phone;

  const UserModel({
    required this.email,
    required this.name,
    required this.phone,
});

  toJson() {
    return {"Name": name, "Email": email, "Phone": phone};
  }
}