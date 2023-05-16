import 'package:TraceBack/posts/create_post/create_post.dart';
import 'package:flutter/material.dart';
import '../main_timeline.dart';

class DatePicker extends StatefulWidget {

  late TextEditingController controller;
  DatePicker({Key? key, required this.controller}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  void _showDatePicker() {
    showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: mainColor),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),

    ).then((value) {
      setState(() {
        widget.controller.text =
        "${(value!).day}/${(value).month}/${(value).year}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text("Date"),
        hintText: "Click calendar >",
        suffixIcon: IconButton(
          onPressed: () {
            _showDatePicker();
          },
          icon: Icon(Icons.calendar_month, color: mainColor),
        ),
        filled: true,
        fillColor: accent,
        enabledBorder: border(mainColor),
        focusedBorder: border(mainColor),
      ),
    );
  }
}