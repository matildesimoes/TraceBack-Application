import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'initial.dart';
import '../posts/timeline.dart';
import 'dart:ui';
import 'dart:io';
import 'signUp.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
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
                    margin: EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.07,
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.09),
                  Container(
                    width: fieldWidth,
                    child: EditBox(text: "Email",hintText: "upXXXXXXXXX@up.pt"),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.0025),
                  Container(
                    width: fieldWidth,
                    child: EditBox(
                      text: "Password",
                      hintText: "Password",
                    ),
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
                            builder: (context) => SearchPage()
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
                        "Enter",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.025),
                  //Spacer(),
                  Container(
  height: constraints.maxHeight * 0.03,
  width: constraints.maxWidth * 0.75,
  child: ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => signUpPage()));
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
        "Don't have an account?",
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

class EditBox extends StatefulWidget {
  final String text;
  final String hintText;

  EditBox({required this.text, required this.hintText});

  @override
  _EditBoxState createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.text == 'Password';
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(2),
      width: 370,
      child: TextFormField(
        keyboardType: widget.text == 'Email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          label: Text(widget.text),
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.grey[300],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(obscureText
                ? Icons.visibility_off
                : Icons.visibility),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
