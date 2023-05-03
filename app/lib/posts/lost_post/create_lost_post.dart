import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/posts/create_post_util/tag_field.dart';
import 'package:TraceBack/posts/post_preview_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../profile/profileBackend.dart';
import '../../util/bottom_button.dart';
import '../create_post_util/description_field.dart';
import '../create_post_util/date_picker.dart';
import '../create_post_util/image_selector.dart';
import '../timeline.dart';
import '../../util/map.dart';
import 'lost_backend.dart';

class CreateLostPost extends StatefulWidget {
  const CreateLostPost({Key? key}) : super(key: key);

  @override
  State<CreateLostPost> createState() => _CreateLostPostState();
}

class _CreateLostPostState extends State<CreateLostPost> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _image;

  getImage(){
    return _image;
  }
  setImage(File? _image){
    setState(() {
      this._image = _image;
    });
  }

  imageValidates(){
    return true;
  }

  TextEditingController titleController = TextEditingController();
  SingleValueDropDownController categoryController = SingleValueDropDownController();
  TextfieldTagsController tagsController = TextfieldTagsController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
  );
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    categoryController.dispose();
    locationController.dispose();
    dateController.dispose();
  }

  preview(){
    if (_formKey.currentState!.validate()){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
            PostPreview(
              tags: tagsController.hasTags ?
              tagsController.getTags.toString().substring(
                  1,
                  tagsController.getTags.toString().length - 1
              ) : "",
              category: categoryController.dropDownValue!.value,
              title: titleController.text,
              location: locationController.text,
              date: dateController.text,
              image: _image,
              description: descriptionController.text,
              authorID: ProfileBackend().getCurrentUserID(),
              submit: submit
            )
        )
      );
    }
  }

  submit () async {
    LostBackend backend = LostBackend();

    String tagsString  = tagsController.hasTags ?

    tagsController.getTags.toString().substring(
        1,
        tagsController.getTags.toString().length - 1
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

    ProfileBackend().addLostItem(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Post Lost Item",
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
                    imageValidates: imageValidates
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
        label: Text("Title"),
      filled: true,
      fillColor: accent,
      enabledBorder: border(mainColor),
      focusedBorder: border(mainColor),
      errorBorder:border(Colors.red),
      focusedErrorBorder: border(Colors.red)
    ),
  );
}

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
          label: Text("Category"),
          filled: true,
          fillColor: accent,
          enabledBorder: border(mainColor),
          focusedBorder: border(mainColor),
          errorBorder:border(Colors.red),
          focusedErrorBorder: border(Colors.red)
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

class LocationField extends StatelessWidget {

  final TextEditingController controller;

  LocationField({
    super.key,
    required this.controller
  });

  void _getLocation(BuildContext context) async {
    final location = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MapBuilder(controller.text))
    );
    controller.text = location;
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
        label: Text("Location"),
        hintText: "Select location >",
        suffixIcon: IconButton(
            onPressed: (){_getLocation(context);},
            icon: Icon(Icons.location_on, color: mainColor)
        ),
        filled: true,
        fillColor: accent,
        enabledBorder: border(mainColor),
        focusedBorder: border(mainColor),
        errorBorder:border(Colors.red),
        focusedErrorBorder: border(Colors.red),
      ),
    );
  }
}

OutlineInputBorder border(Color color) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
          color: color,
          width: 2,
          style: BorderStyle.solid
      )
  );
}