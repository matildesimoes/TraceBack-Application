import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/profile.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';

class EditBox extends StatelessWidget {
  final String text;
  final String hintText;
  bool isPassword;

  EditBox({required this.text, required this.hintText, this.isPassword = false});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(2),
      width: 370,
      child: TextFormField(
        keyboardType: this.text == 'Email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          label: Text(this.text),
          hintText: this.hintText,
          suffixIcon: this.text == 'Password'
              ? IconButton(
                  onPressed: () {
                      this.isPassword = !this.isPassword;
                  },
                  icon: Icon(
                    this.isPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
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
        validator: this.text == "Name"
            ? (value) => nameValidator.validate(value)
            : this.text == "Email"
                ? (value) => emailValidator.validate(value)
                : this.text == "Phone Number"
                    ? (value) => phoneValidator.validate(value)
                    : this.text == "Password"
                        ? (value) => PasswordValidator.validate(value)
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

class PasswordValidator {
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

