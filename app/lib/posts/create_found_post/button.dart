import 'dart:ui';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../post_fake_backend.dart';
import '../timeline.dart';

class PostButton extends StatefulWidget {

  PostButton({
    super.key,
    required this.clicked,
    required this.imageSelected,
    required GlobalKey<FormState> formKey,
    required this.tagsController,
    required this.titleController,
    required this.categoryController,
    required this.locationController,
    required this.dateController,
  }) : _formKey = formKey;

  late dynamic Function(bool) clicked;
  late bool imageSelected;
  final GlobalKey<FormState> _formKey;
  final TextfieldTagsController tagsController;
  final TextEditingController titleController;
  final SingleValueDropDownController categoryController;
  final TextEditingController locationController;
  final TextEditingController dateController;

  @override
  State<PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 200,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                widget.clicked(true);
              });
              if (widget._formKey.currentState!.validate() && widget.imageSelected) {
                String tagsString = "";
                for (String tag in widget.tagsController.getTags!) {
                  tagsString += '$tag,';
                }
                tagsString = tagsString.substring(0, tagsString.length - 1);
                FakePostBackend.addToCollection(
                    {
                      'title': widget.titleController.text,
                      'category': widget.categoryController.dropDownValue!
                          .value,
                      'tags': tagsString,
                      'location': widget.locationController.text,
                      'date': widget.dateController.text,
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