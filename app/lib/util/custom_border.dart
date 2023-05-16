import 'package:flutter/material.dart';

class CustomBorder extends OutlineInputBorder{

  CustomBorder(Color color) : super(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
          color: color,
          width: 1,
          style: BorderStyle.solid
      )
  );
}