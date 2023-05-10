import 'dart:io';
import 'dart:ui';

import 'package:TraceBack/util/camera.dart';
import 'package:flutter/material.dart';
import '../main_timeline.dart';

class ImageSelector extends StatefulWidget {

  const ImageSelector({
    required this.setImage,
    required this.getImage,
    Key? key}) : super(key: key);

  final Function() getImage;
  final Function(File? _image) setImage;

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {

  setImage() async {
    File? image = await ImageHandler.getImage(context);
    if (image != null){
      setState(() {
        widget.setImage(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){if(widget.getImage() == null) setImage();},
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
                border: Border.all(color: mainColor)
            ),
            child: widget.getImage() != null ?
            ClipOval(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: ImageFiltered(
                    child: Image.file(widget.getImage()!),
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
              color: accent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: mainColor)
          ),
          child: IconButton(
              onPressed: setImage,
              icon: Icon(Icons.camera_alt, color: mainColor,)
          ),
        )
      ],
    );
  }
}