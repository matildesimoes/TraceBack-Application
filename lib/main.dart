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
          children: <Widget>[
            Row (
              children: [
                Text("All"),
                Text("Phones")
              ],
            ),
            Expanded(
                child: ListView.builder(
                itemBuilder: (_,index){
                  return Container(
                    width:  double.maxFinite,
                    height: 130,
                    margin: const EdgeInsetsDirectional.only(
                        top: 30,
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
                                  Icons.phone_android,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column (
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
                            )
                            ,
                            Row(
                              children: [
                                tag("Tag1"),
                                tag("Tag2")
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomStart,
                              child: Row (
                                children: [
                                  Text("Location"),
                                  Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Text("Author")
                                  )
                                ],
                              )
                            )
                          ],
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
          
          child: Padding(padding: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              TextButton(onPressed: () {}, child: Text("Chat")),
              TextButton(onPressed: () {}, child: Text("Profile")),
              TextButton(onPressed: () {}, child: Text("Settings"))
            ],
          )),
        ),
      ),
    );
  }

}

