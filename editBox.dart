import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/profile.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';

class EditBox extends StatefulWidget {
  final String text;
  final String hintText;
  bool isPassword;

  EditBox({required this.text, required this.hintText, this.isPassword = false});

  @override
  _EditBoxState createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  final controller = TextEditingController();

  void _handleTextChange(String text) {
    try {
      // remove a character when the user presses the backspace button
      if (text.isEmpty && controller.text.isNotEmpty) {
        controller.text = controller.text.substring(0, controller.text.length - 1);
        return; // exit the function early to prevent assertion error
      }

      // handle only character inputs
      if (text.length == 1) {
        // code to manipulate text
      }
    } catch (e, stackTrace) {
      print('Error: $e\nStackTrace: $stackTrace');
    }
  }

  void deleteCharacter() {
    final oldValue = controller.text;
    final selection = controller.selection;
    final text = oldValue.substring(0, selection.start - 1) + oldValue.substring(selection.start);
    final newSelection = selection.copyWith(
      baseOffset: selection.start - 1,
      extentOffset: selection.start - 1,
    );
    controller.value = TextEditingValue(
      text: text,
      selection: newSelection,
    );
  }

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
        controller: controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          label: Text(widget.text),
          hintText: widget.hintText,
          suffixIcon: widget.text == 'Password'
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  icon: Icon(
                    widget.isPassword ? Icons.visibility_off : Icons.visibility,
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
        validator: widget.text == "Name"
            ? (value) => nameValidator.validate(value)
            : widget.text == "Email"
                ? (value) => emailValidator.validate(value)
                : widget.text == "Phone Number"
                    ? (value) => phoneValidator.validate(value)
                    : widget.text == "Password"
                        ? (value) => PasswordValidator.validate(value)
                        : null,
        onChanged: _handleTextChange,
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

