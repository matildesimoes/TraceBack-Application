import 'package:TraceBack/profile/profile.dart';
import 'package:TraceBack/profile/profilePage.dart';
import 'package:TraceBack/util/colors.dart';
import 'package:TraceBack/posts/post_pages/post.dart';
import 'package:flutter/material.dart';
import '../../util/bottom_button.dart';
import '../../util/camera.dart';
import '../main_timeline.dart';

class PostPage extends StatelessWidget {

  late String title;
  List<Tag> tags = [];
  late String location;
  late String? imageURL;
  late String description;
  late String date;
  late String authorID;
  late bool isClosed;

  PostPage({Key? key,
    required this.isClosed,
    required this.tags,
    required this.title,
    required this.location,
    required this.imageURL,
    required this.date,
    required this.description,
    required this.authorID
  }
      ) : super(key: key);

  Future<Widget> imageRetriever() async {
    if (imageURL == null)
      return SizedBox.shrink();
    try {
      return await ImageHandler().getPictureFrame(imageURL!);
    } catch (e){
      return SizedBox.shrink();
    }
  }

  contact(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfilePage(userID: authorID)
      )
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
      body: Column(
        children: [
          Post(tags: tags, title: title, location: location,
            description: description, imageRetriever: imageRetriever,
            date: date, authorID: authorID,),
        ]
      ),
      floatingActionButton: BottomButton(
        text: isClosed ? "Go Back" : "Contact",
        icon: isClosed ? Icons.arrow_back_ios : Icons.message_outlined,
        onPressed: isClosed ?
            (){Navigator.pop(context);} :
            (){contact(context);}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
