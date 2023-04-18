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
       body: LayoutBuilder(
      builder: ( context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double fieldWidth = maxWidth * 1;
        final double buttonWidth = maxWidth * 0.6;
        final double minHeight = 50;

        return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.07),
                  Container(
                    margin: EdgeInsets.only(bottom:10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.07,
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.0025),
                  Container(
                    width: fieldWidth,
                    child: EditBox(text: "Name", hintText: "Name", isPassword: false)
                    ),
                  SizedBox(height: constraints.maxHeight * 0.0025),
                  Container(
                    width: fieldWidth,
                    child: EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt", isPassword: false)
                    ),
                  SizedBox(height: constraints.maxHeight * 0.0025),
                  Container(
                    width: fieldWidth,
                    child: EditBox(text: "Phone Number", hintText: "Phone Number", isPassword: false)
                    ),
                  SizedBox(height: constraints.maxHeight * 0.0025),
                  Container(
                    width: fieldWidth,
                    child: EditBox(text: "Password", hintText: "Enter password", isPassword: true)
                    ),
                  SizedBox(height: constraints.maxHeight * 0.0025),
                  Container(                   
                    width: fieldWidth,
                    child: EditBox(text: "Confirm Password", hintText: "Confirm password", isPassword: true)
                    ),

                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.08,
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.025, bottom: constraints.maxHeight * 0.0125),
                    width: constraints.maxWidth * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage()
                            )
                          );
                        }
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
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.025),
                  Container(
  height: constraints.maxHeight * 0.03,
  width: constraints.maxWidth * 0.75,
  child: ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      elevation: MaterialStateProperty.all<double>(0),
      side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Text(
        "Already have an account?",
        style: TextStyle(
          fontSize: constraints.maxWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: mainColor,
        ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
          ),
      
        );
      },
    ),
  );
}
}