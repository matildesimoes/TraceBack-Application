import 'package:TraceBack/posts/main_timeline.dart';
import 'package:TraceBack/profile/profile.dart';
import 'package:flutter/material.dart';

import '../util/colors.dart';

class ProfilePage extends StatelessWidget {

  final String userID;

  const ProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          backgroundColor: mainColor,
          toolbarHeight: 80,
        ),
        body: Profile(
          userID: userID,
          isCurrentUser: false,
        )
    );
  }
}
