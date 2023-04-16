import 'package:TraceBack/profile/profile.dart';
import 'package:TraceBack/terms&guidelines/privacyAcceptance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../posts/timeline.dart';
import 'dart:ui';


class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                                builder: (context) => PrivacyAcceptancePage()
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
                              builder: (context) => ProfilePage()
                          )
                      );
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

class EditBox extends StatefulWidget {
  final String text;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  EditBox({required this.text, required this.hintText, this.isPassword = false, this.controller});

  @override
  _EditBoxState createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  bool obscureText = true;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(2),
      width: 370,
      child: TextFormField(
        keyboardType: widget.text == 'Email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: widget.isPassword ? obscureText : false,
        decoration: InputDecoration(
          label: Text(widget.text),
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(obscureText
                ? Icons.visibility_off
                : Icons.visibility),
          )
              : null,
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
        ),
        onChanged: (value) {
          if (widget.text == "Password") {
            setState(() {
              password = value;
            });
            if (confirmPassword != null && confirmPassword != value) {
              setState(() {
                confirmPassword = null;
              });
            }
            password = value;
          }
        },
        validator: widget.text == "Name"
            ? (value) => nameValidator.validate(value)
            : widget.text == "Email"
            ? (value) => emailValidator.validate(value)
            : widget.text == "Phone Number"
            ? (value) => phoneValidator.validate(value)
            : widget.text == "Password"
            ? (value) => passwordValidator.validate(value)
            : null,
      ),
    );
  }
}

class nameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
}

class emailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an UP email address';
    }

    final upEmailRegex = RegExp(r'^up[0-9]+@up\.pt$');
    if (!upEmailRegex.hasMatch(value)) {
      return 'Please enter a valid UP email address';
    }

    return null;
  }
}

class phoneValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    final upEmailRegex = RegExp(r'^[0-9]*$');
    if (!upEmailRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}

class passwordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    return null;
  }
}
