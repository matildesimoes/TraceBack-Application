import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/posts/create_post_util/tag_field.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../timeline.dart';
import '../../util/map.dart';
import 'button.dart';
import '../create_post_util/date_picker.dart';
import '../create_post_util/image_selector.dart';

class CreateFoundPost extends StatefulWidget {
  const CreateFoundPost({Key? key}) : super(key: key);

  @override
  State<CreateFoundPost> createState() => _CreateFoundPostState();
}

class _CreateFoundPostState extends State<CreateFoundPost> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _imageSelected = false;
  bool _clicked = false;

  List<String> tags = [];

  File? _image;

  getImage(){
    return _image;
  }
  setImage(File? _image){
    setState(() {
      this._image = _image;
      _imageSelected = true;
    });
  }

  imageValidates(){
    if (!_imageSelected && _clicked) {
      return false;
    }
    return true;
  }

  TextEditingController titleController = new TextEditingController();
  SingleValueDropDownController categoryController = new SingleValueDropDownController();
  TextfieldTagsController tagsController = new TextfieldTagsController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
  );

  setClicked(bool cond){
    setState(() {
      _clicked = cond;
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    categoryController.dispose();
    tagsController.dispose();
    locationController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Post Found Item",
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
      body: Form(
          key: _formKey,
          child: Scrollbar(
            thickness: 7,
            thumbVisibility: true,
            radius: Radius.circular(10),
            child: Column(
              children: [
                Expanded(
                  flex: 20,
                  child: ListView(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
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
                      ImageSelector(
                          setImage: setImage,
                          getImage: getImage,
                          imageValidates: imageValidates),
                    ],
                  ),
                ),
                Spacer(),
                SubmitFoundButton(
                    clicked: setClicked,
                    imageSelected: _imageSelected,
                    formKey: _formKey,
                    tagsController: tagsController,
                    titleController: titleController,
                    categoryController: categoryController,
                    locationController: locationController,
                    dateController: dateController
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
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
      fillColor: grey,
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
          fillColor: grey,
          enabledBorder: border(mainColor),
          focusedBorder: border(mainColor),
          errorBorder:border(Colors.red),
          focusedErrorBorder: border(Colors.red)
      ),
      dropDownList: [
        DropDownValueModel(name: 'All', value: "All"),
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
        MaterialPageRoute(builder: (context) => Map(controller.text))
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
        fillColor: grey,
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