import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'package:TraceBack/util/colors.dart';
import 'dart:async';


class Profile extends StatefulWidget{

  final String userID;
  final bool isCurrentUser;

  const Profile({
    Key? key,
    required this.userID,
    this.isCurrentUser = false}
  ) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  late final FirebaseFirestore firestore;
  late final FirebaseStorage storage;

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(
        widget.userID).get();
    String photoUrl;
    try {
      photoUrl = await storage.ref('Profile Pics/${widget.userID}/ProfilePic.jpg')
          .getDownloadURL();
    } catch (e) {
      photoUrl = '';
    }
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    userData['photoUrl'] = photoUrl;
    return userData;
  }

  @override
  void initState() {
    storage = FirebaseStorage.instance;
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final userData = snapshot.data!;
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40), // Adjust as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                      child: userData['photoUrl'] != ''
                          ? Image.network(
                        userData['photoUrl'],
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 140,
                        height: 140,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      userData['name'] as String,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      userData['email'] as String,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      userData['phone'] as String,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    widget.isCurrentUser ?  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Edit Profile'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(
                                      () {
                                    setState(() {
                                      getUserData();
                                    });
                                  },
                                ),
                          ),
                        );
                      },
                    ) : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}