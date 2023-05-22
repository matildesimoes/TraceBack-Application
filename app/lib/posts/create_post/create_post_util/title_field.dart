import 'package:TraceBack/util/colors.dart';
import 'package:TraceBack/util/custom_border.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;

  TitleField({
    super.key, required this.controller,
  });

  static String? validator(String?value){
    if (value == "")
      return "Please type a title!";
    return null;
  }
  @override
  Widget build(BuildContext context) => TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
        label: Text("Title *"),
        filled: true,
        fillColor: accent,
        enabledBorder: CustomBorder(mainColor),
        focusedBorder: CustomBorder(mainColor),
        errorBorder:CustomBorder(Colors.red),
        focusedErrorBorder: CustomBorder(Colors.red)
    ),
  );
}