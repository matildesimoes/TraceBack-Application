import 'dart:ui';
import 'package:flutter/material.dart';
import 'timeline.dart';

class Post extends StatefulWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  String? imageURL;

  Post({Key? key, required this.tags, required this.title,
    required this.location, this.imageURL}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Title(
                  color: mainColor,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor
                    ),
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 100.0,
                  child: ClipOval(
                      child: ImageFiltered(
                        child: Image(
                          image: AssetImage("assets/SamsungS10.jpg"),
                        ),
                        imageFilter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                      )
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                direction: Axis.horizontal,
                children: widget.tags,
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.location,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),
            Container(
              height: 250,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: mainColor,
                  width: 2
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/mapa.jpg"),
              )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 40,
                width: 110,
                margin: EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )
                        )
                    ),
                    onPressed: (){},
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset("assets/profile.jpg"),
                        ),
                        Text("Mariana", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  )
                )
              ),
            ),
            Container(
              height: 60,
              width: 200,
              child: TextButton.icon(
                onPressed: (){},
                icon: Icon(Icons.message, color: Colors.white, size: 23,),
                label: Text("Contact", style: TextStyle(color: Colors.white, fontSize: 17),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )
                    )
                ),
              ),
            )
          ],
        ),
      )
    ),
  );
}
