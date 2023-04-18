import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
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

  Future<Widget> getPictureFrame(String imageURL) async{

    if (imageURL == "null") {
      return SizedBox(width: 50);
    }
    else {
      String url = await FirebaseStorage.instance.refFromURL(imageURL).getDownloadURL();
      return Container(
          height: 100.0,
          width: 100.0,
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: ClipOval(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                child: Image.network(url),
              )
          )
      );
    }
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
              await getImage(ImageSource.gallery);
              Navigator.pop(context, image);
            },
          ),
        ],
      ),
    );
  }
}