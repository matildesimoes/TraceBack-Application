import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Color mainColor = const Color(0xFF1D3D5C);

  final Color grey = const Color(0xFFEBEAEA);

  MyApp ({Key? key}) : super(key: key);

  TextButton category(String text){
    return TextButton(
        onPressed: (){},
        child: Text(
          text,
          style: TextStyle(color: mainColor),
        )
    );
  }

  Expanded bottomButton(String text){
    return Expanded(child: TextButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<ContinuousRectangleBorder>(
            ContinuousRectangleBorder()
        ),
        backgroundColor: MaterialStateProperty.all<Color>(mainColor)
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          )
      ),
    ),
    );
  }

  Container tag(String tagText) {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10
        ),
        margin: const EdgeInsetsDirectional.only(
            top: 10,
            end: 10
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: mainColor,
            border: Border.all(
                style: BorderStyle.solid,
                color: mainColor
            )
        ),
        child: Text(
          tagText,
          style: const TextStyle(
              color: Colors.white
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(

          title: const Text("Lost&Found"),
          centerTitle: true,
          backgroundColor: mainColor,
          toolbarHeight: 80,
        ),
        floatingActionButton: FractionallySizedBox (
          widthFactor: 0.2,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: mainColor,
              onPressed: () {  },
              child: const Icon(Icons.add),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 70, minHeight: 50),
              child:ListView (
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  category("All"),
                  category("IT Devices"),
                  category("Keys"),
                  category("Clothing"),
                  category("School Supplies"),
                  category("Other")
                ],
              )
            ),
            Expanded(
                child: ListView.builder(
                itemBuilder: (_,index){
                  return Container(
                    width:  double.maxFinite,
                    height: 130,
                    margin: const EdgeInsetsDirectional.only(
                        bottom: 30,
                        start: 20,
                        end: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: grey,
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: grey
                        )
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: const <Widget>[
                              Positioned(
                                top: 25.0,
                                left: 25.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded (
                            child:Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    tag("Tag1"),
                                    tag("Tag2")
                                  ],
                                ),
                                Expanded (
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child:Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Row (
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Location",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: mainColor),
                                          ),
                                          Text(
                                            "Author",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: mainColor),
                                          )
                                        ],
                                      )
                                    )
                                  )
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  );
                }
              )
            )
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            bottomButton("Found"),
            bottomButton("Lost")
          ],
        ),
        drawer: Drawer(
          width: 200,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 132,
                    color: mainColor,
                  ),
                  const Positioned(
                    top: 65,
                    left: 75,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.chat, color: mainColor,),
                  label: Text("Chat", style: TextStyle(color: mainColor),),
                )
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.account_circle, color: mainColor,),
                    label: Text("Profile", style: TextStyle(color: mainColor),),
                )
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.settings, color: mainColor,),
                  label: Text("Settings", style: TextStyle(color: mainColor)),
                )
              ),
              const Spacer(
                flex: 6,
              ),
              Container (
                width: 200,
                height: 60,
                color: mainColor,
                child:TextButton(
                  onPressed: (){},
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                )
              )
            ],
          )
        ),
      ),
    );
  }

}

