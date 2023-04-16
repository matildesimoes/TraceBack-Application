import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../posts/timeline.dart';
import 'dart:ui';
import 'signUp.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(bottom:6),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 24,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt"),
              SizedBox(height: 10),
              EditBox(text: "Password", hintText: "Password"),
              SizedBox(height: 30),
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 50),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SearchPage())
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
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(top: 170),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUpPage())
                        );
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        foregroundColor: MaterialStateProperty.all<Color>(mainColor),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text("SignUp"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
