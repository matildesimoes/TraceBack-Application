import 'dart:ui';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../timeline.dart';
import 'lost_backend.dart';

class SubmitLostButton extends StatefulWidget {

  SubmitLostButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.tagsController,
    required this.titleController,
    required this.categoryController,
    required this.locationController,
    required this.dateController,
    required this.descriptionController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextfieldTagsController tagsController;
  final TextEditingController titleController;
  final SingleValueDropDownController categoryController;
  final TextEditingController locationController;
  final TextEditingController dateController;
  final TextEditingController descriptionController;

  @override
  State<SubmitLostButton> createState() => _SubmitLostButtonState();
}

class _SubmitLostButtonState extends State<SubmitLostButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 200,
          child: TextButton.icon(
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                String tagsString = "";
                if (widget.tagsController.hasTags){
                  for (String tag in widget.tagsController.getTags!) {
                    tagsString += '$tag,';
                  }
                  tagsString = tagsString.substring(0, tagsString.length - 1);
                }
                LostBackend().addToCollection(
                    {
                      'title': widget.titleController.text,
                      'category': widget.categoryController.dropDownValue!
                          .value,
                      'tags': tagsString,
                      'location': widget.locationController.text,
                      'date': widget.dateController.text,
                      'description': widget.descriptionController.text
                    }
                );
                Navigator.pop(context);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(mainColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            label: Text(
              "Post",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(Icons.post_add, color: Colors.white,),
          ),
        ),
      ],
    );
  }
}