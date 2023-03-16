import 'dart:ui';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';


class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
          child: Column(
            children: [
              SizedBox(height: 35),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: grey,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: mainColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 18),
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
              EditBox(text: "Name"),
              EditBox(text: "Email",),
              EditBox(text: "Phone Number"),
              SizedBox(height: 40),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 16),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // função para salvar as informações
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

class EditBox extends StatelessWidget{

  final String text;
  EditBox({required this.text});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(top:19),
    padding: EdgeInsets.all(2),
    width: 370,
    decoration: BoxDecoration(
      color: grey,
      borderRadius: BorderRadius.circular(40),
    ),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              new TextEditingController().clear();
            },
            child: TextField(
              decoration: InputDecoration(
                label: Text(text),
                hintText: "$text >",
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
            ),
          ),
        ),
      ],
    ),
  );
}
