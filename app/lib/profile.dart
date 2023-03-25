import 'dart:ui';
import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'main.dart';
import 'editBox.dart';

class ProfilePage extends StatefulWidget{

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          backgroundColor: mainColor,
          toolbarHeight: 80,
        ),
        body: Column(
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
                      backgroundColor: grey,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'David',
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
                              'david@gmail.com',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              '967848691',
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
          ],
        ),
      ),
    );
  }
}