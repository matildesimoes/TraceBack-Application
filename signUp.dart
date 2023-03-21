import 'package:TraceBack/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'main.dart';
import 'dart:ui';


class signUpPage extends StatefulWidget {
  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 25,top: 45),
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
              EditBox(text: "Name", hintText: "Name"),
              EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt"),
              EditBox(text: "Phone Number", hintText: "Phone Number"),
              EditBox(text: "Password", hintText: "Password"),

              SizedBox(height: 40),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 5),
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
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
