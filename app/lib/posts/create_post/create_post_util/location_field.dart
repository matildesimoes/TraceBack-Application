import 'package:TraceBack/util/colors.dart';
import 'package:TraceBack/util/map.dart';
import 'package:TraceBack/util/custom_border.dart';
import 'package:flutter/material.dart';

class LocationField extends StatelessWidget {

  final TextEditingController controller;

  LocationField({
    super.key,
    required this.controller
  });

  void _getLocation(BuildContext context) async {
    final Place location = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MapBuilder(controller.text))
    );
    controller.text = location.address;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Please select a location";
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        label: Text("Location *"),
        hintText: "Select location >",
        suffixIcon: IconButton(
            onPressed: (){_getLocation(context);},
            icon: Icon(Icons.location_on, color: mainColor)
        ),
        filled: true,
        fillColor: accent,
        enabledBorder: CustomBorder(mainColor),
        focusedBorder: CustomBorder(mainColor),
        errorBorder: CustomBorder(Colors.red),
        focusedErrorBorder: CustomBorder(Colors.red),
      ),
    );
  }
}