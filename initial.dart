import 'dart:io';

import 'package:TraceBack/profile.dart';
import 'package:TraceBack/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'editprofile.dart';
import 'login.dart';
import 'main.dart';
import 'dart:ui';


class initialPage extends StatefulWidget {
  @override
  State<initialPage> createState() => _initialPageState();
}

class _initialPageState extends State<initialPage>{
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        drawer: SideMenu(),
    backgroundColor : mainColor,
    body: SingleChildScrollView(
    child: Form(
    key: _formKey,
    child: Column(
            children: [
              SizedBox(height: 35),
              CircleAvatar(
                child: Align(
                  alignment: Alignment.center),
                    radius: 70,
                    backgroundColor: grey,
                    backgroundImage: AssetImage("assets/logo.png"),

                  ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(top: 45, bottom: 20),
                margin: EdgeInsets.only(bottom:10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'TraceBack',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 5),
                width: 275,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => LoginPage()
                          )
                      );
                    }
                    // função para guardar as informações
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 5),
                width: 275,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => signUpPage()
                          )
                      );
                    }
                    // função para guardar as informações
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
