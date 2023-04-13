import 'package:TraceBack/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/editBox.dart';
import '../posts/timeline.dart';
import 'dart:ui';
import 'login.dart';


class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: mainColor,
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Container(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                EditBox(text: "Name", hintText: "Name", isPassword: false),
                EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt", isPassword: false),
                EditBox(text: "Phone Number", hintText: "Phone Number", isPassword: false),
                EditBox(text: "Password", hintText: "Enter password", isPassword: true),
                EditBox(text: "Confirm Password", hintText: "Confirm password", isPassword: true),

                SizedBox(height: 15),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 10, bottom: 5),
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
                SizedBox(height: 50),
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
                        fontSize: 14,
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
  }
}