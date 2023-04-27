import 'dart:ui';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:TraceBack/terms&guidelines/privacyInformation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'package:TraceBack/profile/profileBackend.dart';
import '../posts/timeline.dart';
import 'dart:async';


class ProfilePage extends StatefulWidget{



  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(user!.uid).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final userData = snapshot.data!;
            return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: accent,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            userData['name'] as String,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            userData['email'] as String,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            userData['phone'] as String,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text('Edit Profile'),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Terms()));},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: Text('Found Item Posts                                       >',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                )
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Terms()));},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: Text('Lost Item Posts                                         >',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                )
            ),
          ),
        ],
            );
        }
    },
            ),
      );
    }
}

class BackEnd {

  BackEnd(){}

  Map<String, Object> doc = {
    "Name" : "David",
    "Email" : "up202112345@up.pt",
    "Phone number" : "912345678",
  };

  Object? get name {
    return doc["Name"];
  }

  Object? get email {
    return doc["Email"];
  }

  Object? get contact {
    return doc["Phone number"];
  }


}

