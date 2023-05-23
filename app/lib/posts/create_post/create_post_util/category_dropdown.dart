import 'package:TraceBack/util/colors.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../../../util/custom_border.dart';

class CategoryDropdown extends StatelessWidget {

  late SingleValueDropDownController controller;

  CategoryDropdown({
    super.key, required this.controller,
  });

  static String? validator(String?value){
    if (value == "")
      return "Please choose a category!";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      validator: validator,
      controller: controller,
      textFieldDecoration: InputDecoration(
          label: Text("Category *"),
          filled: true,
          fillColor: accent,
          enabledBorder: CustomBorder(mainColor),
          focusedBorder: CustomBorder(mainColor),
          errorBorder: CustomBorder(Colors.red),
          focusedErrorBorder: CustomBorder(Colors.red)
      ),
      dropDownList: [
        DropDownValueModel(name: 'IT Devices', value: "IT Devices"),
        DropDownValueModel(name: 'Keys', value: "Keys"),
        DropDownValueModel(name: 'Clothing', value: "Clothing"),
        DropDownValueModel(name: 'School Supplies', value: "School Supplies"),
        DropDownValueModel(name: 'Other', value: "Other"),
      ],
    );
  }
}