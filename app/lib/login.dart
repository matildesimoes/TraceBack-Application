import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'initial.dart';
import 'main.dart';
import 'dart:ui';
import 'dart:io';
import 'editBox.dart';
import 'signUp.dart';



class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
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
                SizedBox(height: 30),
                Container(
                  //padding: EdgeInsets.only(left:25),
                  margin: EdgeInsets.only(bottom:10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt",isPassword: false),
                EditBox(text: "Password", hintText: "Password",isPassword: true),
                SizedBox(height: 60),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context)
                            .push(
                            MaterialPageRoute(builder: (context) => MainPage()
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
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  height: 25,
                  width: 300,
                  margin: const EdgeInsets.only(top: 300),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => signUpPage()
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
                      "Dont have an account? SignUp",
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
        ),
      ),
    );
  }}