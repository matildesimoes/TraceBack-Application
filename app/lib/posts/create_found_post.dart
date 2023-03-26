import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/posts/post_fake_backend.dart';
import 'package:TraceBack/util/camera.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../main.dart';
import '../map.dart';

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
  TextFieldTagsController tagsController = new TextFieldTagsController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController dateController = new TextEditingController(
      text: DateTime.now().day.toString() + "/" +
          DateTime.now().month.toString() + "/" +
          DateTime.now().year.toString()
  );

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
                TagField(tags: tags, controller: tagsController),
                SizedBox(
                  height: 10,
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){if(_image == null) setImage();},
                      child: Container(
                        height: 200,
                        width: 200,
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
                            child: Expanded(child: Icon(Icons.image, color: Colors.black45)),
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
                    for (String tag in tagsController.getAllTags) {
                      tagsString += '$tag,';
                    }
                    FakePostBackend.addColection(
                      {
                        'title': titleController.text,
                        'category': categoryController.dropDownValue!.value,
                        'tags': tagsString,
                        'location': locationController.text,
                        'date': dateController.text,
                      }
                    );
                    tagsController.dispose();
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
  const TagField({
    super.key,
    required this.tags,
    required TextFieldTagsController controller,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      tagsDistanceFromBorderEnd: 1,
      textSeparators: [
        " ", //seperate with space
        ',', //sepearate with comma as well
        ";"
      ],
      initialTags: tags,
      onTag: (tag){
        //this will give tag when entered new single tag
        tags.add(tag);
      },
      onDelete: (tag){
        //this will give single tag on delete
        tags.remove(tag);
      },
      validator: (tag){
        //add validation for tags
        if(tag.length < 3){
          return "Enter tag up to 3 characters.";
        }
        return null;
      },
      tagsStyler: TagsStyler( //styling tag style
          tagTextStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
          tagDecoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20.0), ),
          tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.white),
          tagPadding: EdgeInsets.all(6.0),
      ),
      textFieldStyler: TextFieldStyler(
        helperText: "Enter Tags",
        textFieldBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: "Tags",
        textFieldFilled: true,
        textFieldFilledColor: grey,
        textFieldFocusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        textFieldEnabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
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
