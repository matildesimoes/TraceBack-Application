import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/profile.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';


class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image = File('logo.png');

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
    ),
    body: SingleChildScrollView(
    child: Form(
    key: _formKey,
    child: Column(
            children: [
              SizedBox(height: 35),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: grey,
                    backgroundImage: _image != null ? FileImage(_image) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: mainColor,
                          size: 24,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text("Take a photo"),
                                      onTap: () {
                                        getImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text("Choose from gallery"),
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 25),
                margin: EdgeInsets.only(bottom:10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Information',
                    style: TextStyle(
                      fontSize: 20,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              EditBox(text: "Name", hintText: "Name"),
              EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt"),
              EditBox(text: "Phone Number", hintText: "Phone Number"),
              SizedBox(height: 40),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 5),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()
                          )
                      );
                    }
                    // função para guardar as informações
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class EditBox extends StatelessWidget {

  final String text;
  final String hintText;
  EditBox({required this.text, required this.hintText});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(2),
      width: 370,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                new TextEditingController().clear();
              },
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller,
                decoration: InputDecoration(
                  label: Text(text),
                  hintText: hintText,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: mainColor),
                  ),
                  filled: true,
                  fillColor: grey,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: mainColor,
                        width: 2,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: mainColor,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                ),
                validator: text == "Name"
                    ? (value) => nameValidator.validate(value)
                    : text == "Email"
                    ? (value) => emailValidator.validate(value)
                    : text == "Phone Number"
                    ? (value) => phoneValidator.validate(value)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class nameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
}

class emailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an UP email address';
    }

    final upEmailRegex = RegExp(r'^up[0-9]+@up\.pt$');
    if (!upEmailRegex.hasMatch(value)) {
      return 'Please enter a valid UP email address';
    }

    return null;
  }
}

class phoneValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    final upEmailRegex = RegExp(r'^[0-9]*$');
    if (!upEmailRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }
}
