import 'dart:io';
import 'dart:ui';
import 'package:TraceBack/profile/profile.dart';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:TraceBack/util/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../posts/timeline.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  File? _image;
  late String uid = FirebaseAuth.instance.currentUser!.uid;
  late String name;
  late String email;
  late String phoneNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late String _imageUrl = '';
  String collection = "Profile Pics";

  void pickUploadImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      final String fileName = uid + DateTime.now().toString() + '.jpg'; // Generate a unique filename
      final Reference ref = _storage.ref().child(collection).child('$fileName');

      UploadTask uploadTask = ref.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print(downloadUrl);

      setState(() {
        _image = File(image.path);
        _imageUrl = downloadUrl;
      });
    }
  }

  void captureImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      final String fileName = uid + DateTime.now().toString() + '.jpg'; // Generate a unique filename
      final Reference ref = _storage.ref().child(collection).child('$fileName');

      UploadTask uploadTask = ref.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print(downloadUrl);

      setState(() {
        _image = File(image.path);
        _imageUrl = downloadUrl;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then(
          (doc) {
        name = doc['name'];
        email = doc['email'];
        phoneNumber = doc['phone'];

        nameController.text = name;
        emailController.text = email;
        phoneNumberController.text = phoneNumber;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    backgroundColor: accent,
                    backgroundImage: _image != null ? FileImage(_image!) : (_imageUrl.isNotEmpty ? NetworkImage(_imageUrl) as ImageProvider<Object>? : null),
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.photo_library,
                                color: mainColor,
                                size: 24,
                              ),
                            onPressed: pickUploadImage,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: mainColor,
                                size: 24,
                              ),
                              onPressed: captureImage,
                            ),
                          ],
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
              EditBox(text: "Name", hintText: "Name", controller: nameController),
              EditBox(text: "Email", hintText: "upXXXXXXXXX@up.pt", controller: emailController),
              EditBox(text: "Phone Number", hintText: "Phone Number", controller: phoneNumberController),
              SizedBox(height: 40),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 5),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        'name': nameController.text,
                        'email': emailController.text,
                        'phone': phoneNumberController.text,
                      };
                      profileBackend.updateProfile(uid, data);
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
    );
  }


}

class EditBox extends StatelessWidget {

  final String text;
  final String hintText;
  final TextEditingController controller;

  EditBox({required this.text, required this.hintText, required this.controller,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(2),
      width: 370,
      child:
      TextFormField(
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
          fillColor: accent,
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