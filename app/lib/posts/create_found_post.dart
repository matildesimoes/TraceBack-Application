import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/posts/post_fake_backend.dart';
import 'package:TraceBack/util/camera.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'timeline.dart';
import '../util/map.dart';

class CreateFoundPost extends StatefulWidget {
  const CreateFoundPost({Key? key}) : super(key: key);

  @override
  State<CreateFoundPost> createState() => _CreateFoundPostState();
}

class _CreateFoundPostState extends State<CreateFoundPost> {

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    categoryController.dispose();
    tagsController.dispose();
    locationController.dispose();
    dateController.dispose();
  }

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
        dateController.text =
            (value!).day.toString() + "/" +
            (value!).month.toString() + "/" +
            (value!).year.toString();
      });
    });
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
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TitleBox(controller: titleController),
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
                TextFormField(
                    readOnly: true,
                    controller: dateController,
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
                      fillColor: grey,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: mainColor,
                              width: 2,
                              style: BorderStyle.solid
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: mainColor,
                              width: 1,
                              style: BorderStyle.solid
                          )
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Container(
                height: 50,
                width: 200,
                child: TextButton.icon(
                  onPressed: () {
                    String tagsString = "";
                    for (String tag in tagsController.getTags!) {
                      tagsString += '$tag,';
                    }
                    tagsString = tagsString.substring(0, tagsString.length-1);
                    FakePostBackend.addToCollection(
                      {
                        'title': titleController.text,
                        'category': categoryController.dropDownValue!.value,
                        'tags': tagsString,
                        'location': locationController.text,
                        'date': dateController.text,
                      }
                    );
                    Navigator.pop(context);
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
            ),
          )
      );
  }

 setImage() async {
   File? image = await ImageHandler.getImage(context);
   if (image != null){
      setState(() {
        _image = image;
      });
    }
  }
}

class TagField extends StatelessWidget {

  TagField({
    super.key,
    required this.controller,
  });

  double _distanceToField = 1;

  final TextfieldTagsController controller;

  @override
  Widget build(BuildContext context) {
    _distanceToField = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: TextFieldTags(
        textfieldTagsController: controller,
        textSeparators: const [' ', ','],
        letterCase: LetterCase.normal,
        /*validator: (String tag) {
          if (tag == 'php') {
            return 'No, please just no';
          } else if (controller.getTags!.contains(tag)) {
            return 'you already entered that';
          }
          return null;
        },*/
        inputfieldBuilder:
            (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, sc, tags, onTagDelete) {
            return TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                    width: 3.0,
                  ),
                ),
                filled: true,
                fillColor: grey,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: mainColor,
                        width: 2,
                        style: BorderStyle.solid
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: mainColor,
                        width: 2,
                        style: BorderStyle.solid
                    )
                ),
                hintText: controller.hasTags ? '' : "Enter tag...",
                errorText: error,
                prefixIconConstraints:
                BoxConstraints(maxWidth: _distanceToField * 0.74),
                prefixIcon: tags.isNotEmpty
                    ?
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: SingleChildScrollView(
                      controller: sc,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: tags.map((String tag) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: mainColor,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '#$tag',
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                    onTap: () {
                                      print("$tag selected");
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                      color: Color.fromARGB(
                                          255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      onTagDelete(tag);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList()),
                    ),
                  )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            );
          });
        },
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {

  late SingleValueDropDownController controller;

  CategoryDropdown({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      controller: controller,
      textFieldDecoration: InputDecoration(
          label: Text("Category"),
        filled: true,
        fillColor: grey,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 2,
                style: BorderStyle.solid
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 1,
                style: BorderStyle.solid
            )
        ),
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

class TitleBox extends StatelessWidget {
  final TextEditingController controller;

  TitleBox({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text("Title"),
        filled: true,
        fillColor: grey,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 2,
                style: BorderStyle.solid
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 1,
                style: BorderStyle.solid
            )
        ),
      ),
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
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 2,
                style: BorderStyle.solid
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: mainColor,
                width: 1,
                style: BorderStyle.solid
            )
        ),
      ),
    );
  }
}
