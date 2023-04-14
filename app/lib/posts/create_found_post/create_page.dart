import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/posts/create_found_post/tag_field.dart';
import 'package:TraceBack/posts/post_fake_backend.dart';
import 'package:TraceBack/util/camera.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../timeline.dart';
import '../../util/map.dart';
import 'date_picker.dart';

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

  TextEditingController titleController = new TextEditingController();
  SingleValueDropDownController categoryController = new SingleValueDropDownController();
  TextfieldTagsController tagsController = new TextfieldTagsController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController dateController = new TextEditingController(
      text: DateTime.now().day.toString() + "/" +
          DateTime.now().month.toString() + "/" +
          DateTime.now().year.toString()
  );

  setImage() async {
    File? image = await ImageHandler.getImage(context);
    if (image != null){
      setState(() {
        _image = image;
        _imageSelected = true;
      });
    }
  }

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){if(_image == null) setImage();},
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: grey,
                              shape: BoxShape.circle,
                              border: Border.all(color: mainColor)
                            ),
                            child: _image != null ?
                              ClipOval(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: ImageFiltered(
                                    child: Image.file(_image!),
                                    imageFilter: ImageFilter.blur(sigmaX: 1.3, sigmaY: 1.3),
                                  ),
                                )
                              ) :
                              SizedBox(
                                child: Icon(Icons.image, color: Colors.black45),
                                width: 100,
                                height: 100,
                              ),
                          ),
                        ),
                        !_imageSelected  && _clicked ?
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            "Please upload an image",
                            style: TextStyle(color: Colors.red),
                          ),
                        ) : Container()
                      ],
                    ),
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: mainColor)
                      ),
                      child: IconButton(
                        onPressed: setImage,
                        icon: Icon(Icons.camera_alt, color: mainColor,)
                      ),
                    )
                  ],
                ),
                Spacer(),
                PostButton(
                  clicked: setClicked,
                  imageSelected: _imageSelected,
                  formKey: _formKey,
                  tagsController: tagsController,
                  titleController: titleController,
                  categoryController: categoryController,
                  locationController: locationController,
                  dateController: dateController
                ),
              ],
            ),
          ),
        )
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
        MaterialPageRoute(builder: (context) => Map())
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
                FakePostBackend.addColection(
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