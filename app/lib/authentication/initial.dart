import 'package:TraceBack/authentication/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import '../posts/main_timeline.dart';
import 'dart:ui';

class InitialPage extends StatefulWidget {
  InitialPage ({Key? key}) : super(key: key);
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>{
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        backgroundColor : mainColor,
        body: Form(
        key: _formKey,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Spacer(),
                  CircleAvatar(
                    child: Align(alignment: Alignment.center),
                    radius: 70,
                    backgroundColor: accent,
                    backgroundImage: AssetImage("assets/logoApp.jpg"),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(bottom:10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'TraceBack',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  LoginButton(),
                  SizedBox(height: 30),
                  SignUpButton(formKey: _formKey),
                  SizedBox(height: 20)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("Sign Up"),
      height: 60,
      margin: EdgeInsets.only(top: 3),
      width: 275,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context)
                .push(
                MaterialPageRoute(
                    builder: (context) => SignUpPage()
                )
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("Login"),
      height: 60,
      margin: EdgeInsets.only(top: 5),
      width: 275,
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
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
      ),
    );
  }
}
