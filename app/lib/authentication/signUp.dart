import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../posts/timeline.dart';
import 'dart:ui';
import '../terms&guidelines/privacyAcceptance.dart';
import 'authentication_backend.dart';
import 'login.dart';


class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<SignUpPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  AuthBackend authBackend = AuthBackend();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String errorMessage = "";

  register() async {
    if (_formKey.currentState!.validate()){
      if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          errorMessage = 'Passwords do not match';
        });
        return;
      }
      Map<String, dynamic> userDoc = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
        'password': passwordController.text,
      };
      String? error = await authBackend.registerUser(userDoc);
      if (error != null) {
        setState(() {
          errorMessage = error;
        });
      }
      else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PrivacyAcceptancePage(),
          )
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("Sign Page"),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName("/")),
        ),
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
                        child: EditBox(key: Key("Name"),text: "Name", hintText: "Name", isPassword: false, controller: nameController, validator: (value) => nameValidator.validate(value))
                    ),
                    SizedBox(height: constraints.maxHeight * 0.0025),
                    Container(
                        width: fieldWidth,
                        child: EditBox(key: Key("Email"),text: "Email", hintText: "upXXXXXXXXX@up.pt", isPassword: false, controller: emailController, validator: (value) => emailValidator.validate(value))
                    ),
                    SizedBox(height: constraints.maxHeight * 0.0025),
                    Container(
                        width: fieldWidth,
                        child: EditBox(key: Key("Phone Number"),text: "Phone Number", hintText: "Phone Number", isPassword: false, controller: phoneNumberController, validator: (value) => phoneValidator.validate(value))
                    ),
                    SizedBox(height: constraints.maxHeight * 0.0025),
                    Container(
                        width: fieldWidth,
                        child: EditBox(key: Key("Password"),text: "Password", hintText: "Enter password", isPassword: true, controller: passwordController, validator: (value) => passwordValidator.validate(value))
                    ),
                    SizedBox(height: constraints.maxHeight * 0.0025),
                    Container(
                        width: fieldWidth,
                        child: EditBox(key: Key("Password Confirm"),text: "Confirm Password", hintText: "Confirm password", isPassword: true, controller: confirmPasswordController, validator: (value) => passwordValidator.validate(value))
                    ),
                    Text(errorMessage),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Container(
                      key: Key("Register"),
                      height: constraints.maxHeight * 0.08,
                      margin: EdgeInsets.only(top: constraints.maxHeight * 0.025, bottom: constraints.maxHeight * 0.0125),
                      width: constraints.maxWidth * 0.5,
                      child: ElevatedButton(
                        onPressed: register,
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
                          Navigator.of(context).popUntil(ModalRoute.withName('/'));
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


class EditBox extends StatefulWidget {
  final Key key;
  final String text;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  EditBox({
    required this.key,
    required this.text,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.validator});

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
        controller: widget.controller,
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
                ? Icons.visibility
                : Icons.visibility_off),
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
        onChanged: (value) {},
        validator: (value) => widget.validator(value),
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
