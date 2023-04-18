import 'dart:io';
import 'dart:ui';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'found_fake_backend.dart';
import '../timeline.dart';

class SubmitFoundButton extends StatefulWidget {

  SubmitFoundButton({
    super.key,
    required this.clicked,
    required this.image,
    required this.formKey,
    required this.tagsController,
    required this.titleController,
    required this.categoryController,
    required this.locationController,
    required this.dateController,
    required this.descriptionController
  });

  late dynamic Function(bool) clicked;
  late File? image;
  final GlobalKey<FormState> formKey;
  final TextfieldTagsController tagsController;
  final TextEditingController titleController;
  final SingleValueDropDownController categoryController;
  final TextEditingController locationController;
  final TextEditingController dateController;
  final TextEditingController descriptionController;

  @override
  State<SubmitFoundButton> createState() => _SubmitFoundButtonState();
}

class _SubmitFoundButtonState extends State<SubmitFoundButton> {

  submit() async {
    setState(() {
      widget.clicked(true);
    });
    if (widget.formKey.currentState!.validate() && widget.image != null) {
      String tagsString = "";
      if (widget.tagsController.hasTags){
      for (String tag in widget.tagsController.getTags!) {
      tagsString += '$tag,';
      }
      tagsString = tagsString.substring(0, tagsString.length - 1);
      }
      Navigator.pop(context);
      FoundBackend backend = FoundBackend();
      String id = await backend.addToCollection(
      {
        'title': widget.titleController.text,
        'category': widget.categoryController.dropDownValue!
            .value,
        'tags': tagsString,
        'location': widget.locationController.text,
        'date': widget.dateController.text,
        'description': widget.descriptionController.text
      });
      String url = await backend.upload(widget.image!, id);
      backend.addURL(id, url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 200,
          child: TextButton.icon(
            onPressed: submit,
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