import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/profile.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'editBox.dart';



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
              EditBox(text: "Name", hintText: "Name", isPassword: false),
              EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt",isPassword: false),
              EditBox(text: "Phone Number", hintText: "Phone Number",isPassword: false),
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
