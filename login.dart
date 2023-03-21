import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'initial.dart';
import 'main.dart';
import 'dart:ui';
import 'dart:io';

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
                EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt"),
                EditBox(text: "Password", hintText: "Password"),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class EditBox extends StatelessWidget {

  final String text;
  final String hintText;
  EditBox({required this.text, required this.hintText});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(2),
      width: 370,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                new TextEditingController().clear();
              },
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller,
                decoration: InputDecoration(
                  label: Text(text),
                  hintText: hintText,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: mainColor),
                  ),
                  filled: true,
                  fillColor: grey,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: mainColor,
                        width: 2,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: mainColor,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                ),
                validator: text == "Name"
                    ? (value) => nameValidator.validate(value)
                    : text == "Email"
                    ? (value) => emailValidator.validate(value)
                    : text == "Phone Number"
                    ? (value) => phoneValidator.validate(value)
                    : null,
              ),
            ),
          ),
        ],
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


