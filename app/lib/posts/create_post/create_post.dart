import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/posts/create_post/create_post_util/category_dropdown.dart';
import 'package:TraceBack/posts/create_post/create_post_util/location_field.dart';
import 'package:TraceBack/posts/create_post/create_post_util/title_field.dart';
import 'package:TraceBack/posts/posts_backend/posts_backend.dart';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:TraceBack/util/colors.dart';

import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../util/bottom_button.dart';
import '../main_timeline.dart';
import 'create_post_util/date_picker.dart';
import 'create_post_util/description_field.dart';
import 'create_post_util/image_selector.dart';
import 'create_post_util/tag_field.dart';

abstract class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState();
}

abstract class CreatePostState extends State<CreatePost> {

  PostsBackend get backend;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formkey => _formKey;

  List<String> tags = [];

  File? _image;

  get image => _image;

  getImage() {
    return _image;
  }

  setImage(File? image) {
    setState(() {
      _image = image;
    });
  }

  TextEditingController titleController = new TextEditingController();
  SingleValueDropDownController categoryController = new SingleValueDropDownController();
  TextfieldTagsController tagsController = new TextfieldTagsController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: "${DateTime
          .now()
          .day}/${DateTime
          .now()
          .month}/${DateTime
          .now()
          .year}"
  );
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    categoryController.dispose();
    tagsController.dispose();
    locationController.dispose();
    dateController.dispose();
  }

  submit() async {

    String tagsString = tagsController.hasTags ?

    tagsController.getTags.toString().substring(
        1,
        tagsController.getTags
            .toString()
            .length - 1
    ) : "";

    Map<String, dynamic> data = {
      'title': titleController.text,
      'category': categoryController.dropDownValue!
          .value,
      'tags': tagsString,
      'location': locationController.text,
      'date': dateController.text,
      'description': descriptionController.text,
      'authorID': ProfileBackend().getCurrentUserID()
    };

    String id = await backend.addToCollection(data);


    if (_image != null) {
      String url = await backend.upload(_image!, id);
      backend.addURL(id, url);
      data['image_url'] = url;
    }

    backend.addItemToUser(id);
  }

  preview();

  String get title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      drawer: SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: Scrollbar(
            thickness: 7,
            thumbVisibility: true,
            radius: Radius.circular(10),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                SizedBox(
                  height: 20,
                ),
                TitleField(controller: titleController),
                SizedBox(
                  height: 20,
                ),
                CategoryDropdown(controller: categoryController),
                SizedBox(
                  height: 20,
                ),
                TagField(controller: tagsController),
                SizedBox(
                  height: 20,
                ),
                LocationField(controller: locationController),
                SizedBox(
                  height: 20,
                ),
                DatePicker(controller: dateController,),
                SizedBox(
                  height: 20,
                ),
                DescriptionField(controller: descriptionController),
                SizedBox(height: 20),
                ImageSelector(
                    setImage: setImage,
                    getImage: getImage,
                ),
                SizedBox(height: 120,)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: BottomButton(
          text: "Preview",
          icon: Icons.remove_red_eye,
          onPressed: preview
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
