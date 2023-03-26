import 'package:TraceBack/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/editBox.dart';
import '../posts/timeline.dart';
import 'dart:ui';
import 'login.dart';


class signUpPage extends StatefulWidget {
  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(),
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 30),
                margin: EdgeInsets.only(bottom:10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 28,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              EditBox(text: "Name", hintText: "Name", isPassword: false),
              EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt", isPassword: false),
              EditBox(text: "Phone Number", hintText: "Phone Number", isPassword: false),
              EditBox(text: "Password", hintText: "Enter password", isPassword: true),
              EditBox(text: "Confirm Password", hintText: "Confirm password", isPassword: true),


              SizedBox(height: 40),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20, bottom: 5),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()
                          )
                      );
                    }
                    // função para guardar as informações
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 25,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => LoginPage()
                          )
                      );
                    // função para guardar as informações
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(0),
                    side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }}