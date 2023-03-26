import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler {

  static Future<File?> getImage(BuildContext context) async {

    final File? image = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerPopUp();
      },
    );

    return image;
  }
}

class ImagePickerPopUp extends StatelessWidget {

  File? image;

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text("Take a photo"),
          onTap: () async {
            await getImage(ImageSource.camera);
            Navigator.pop(context, image);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Choose from gallery"),
            onTap: () async {
              await getImage(ImageSource.camera);
              Navigator.pop(context, image);
            },
          ),
        ],
      ),
    );
  }
}