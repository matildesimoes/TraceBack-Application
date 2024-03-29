import 'dart:io';
import 'package:TraceBack/profile/profileBackend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../posts/main_timeline.dart';
import 'package:TraceBack/util/colors.dart';

class EditProfilePage extends StatefulWidget {

  final VoidCallback refresh;

  const EditProfilePage(this.refresh, {super.key});

  @override
  State<EditProfilePage> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {

  late FirebaseFirestore firestore;
  late FirebaseStorage storage;

  late User? user;

  File? _image;
  late String uid;
  late String name;
  late String phoneNumber;
  late Map<String, dynamic> userData = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  late final FirebaseStorage _storage;
  late String _imageUrl = '';
  String collection = "Profile Pics";

  Future<String?> getProfilePictureUrl() async {
    try {
      final Reference ref =
      _storage.ref().child(collection).child('$uid/ProfilePic.jpg');
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  void pickUploadImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (image != null) {
      final String fileName = 'ProfilePic.jpg'; // Generate a unique filename
      final Reference ref = _storage.ref().child(collection).child('$uid/$fileName');

      UploadTask uploadTask = ref.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _image = File(image.path);
        _imageUrl = downloadUrl;
        userData['photoUrl'] = _imageUrl;
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
      final String fileName = 'ProfilePic.jpg'; // Generate a unique filename
      final Reference ref = _storage.ref().child(collection).child('$uid/$fileName');

      UploadTask uploadTask = ref.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _image = File(image.path);
        _imageUrl = downloadUrl;
        userData['photoUrl'] = _imageUrl;
      });
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot snapshot = await firestore.collection("Users").doc(
        user!.uid).get();
    String photoUrl;
    try {
      photoUrl = await storage.ref('Profile Pics/${user!.uid}/ProfilePic.jpg')
          .getDownloadURL();
    } catch (e) {
      photoUrl = '';
    }
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    userData['photoUrl'] = photoUrl;
    return userData;
  }

  @override
  void initState() {

    firestore = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;

    _storage = FirebaseStorage.instance;
    super.initState();
    getUserData().then((data) {
      setState(() {
        userData = data;
      });
    });
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then(
          (doc) {
        name = doc['name'];
        phoneNumber = doc['phone'];

        nameController.text = name;
        phoneNumberController.text = phoneNumber;

        setState(() {
          _imageUrl = doc['photoUrl'] as String ?? '';
          if (_imageUrl.isNotEmpty) {
            _image = File.fromUri(Uri.parse(_imageUrl));
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: mainColor,
      toolbarHeight: 80,
      leading: BackButton(),
    ),
    body: userData.isEmpty ? Center(child: CircularProgressIndicator()) :
      Stack(
        alignment: Alignment.center,
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: [
                SizedBox(height: 35),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: userData.containsKey('photoUrl') && userData['photoUrl'] != ''
                          ? Image.network(
                        userData['photoUrl'] as String,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 140,
                        height: 140,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: MediaQuery.of(context).size.width / 2 - 30,
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
                  margin: EdgeInsets.only(bottom: 10),
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
              EditBox(text: "Phone Number", hintText: "Phone Number", controller: phoneNumberController),
              SizedBox(height: 40),
              ],
            ),
          ),
          Column(
            children: [
              Spacer(),
              SaveButton(
                formKey: _formKey,
                nameController: nameController,
                phoneNumberController: phoneNumberController,
                uid: uid,
                widget: widget
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.phoneNumberController,
    required this.uid,
    required this.widget,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final String uid;
  final EditProfilePage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 5),
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Map<String, dynamic> data = {
              'name': nameController.text,
              'phone': phoneNumberController.text,
            };
            ProfileBackend().updateProfile(uid, data);
            widget.refresh();
            Navigator.of(context).pop();
          }
          // função para guardar as informações
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
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
      );
  }
}

class EditBox extends StatelessWidget {

  final String text;
  final String hintText;
  final TextEditingController controller;

  const EditBox({required this.text, required this.hintText, required this.controller,});

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