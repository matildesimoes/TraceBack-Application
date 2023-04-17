import 'package:flutter/material.dart';
import '../posts/timeline.dart';

class GuidelinesPage extends StatefulWidget {
  @override
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
        title: Text('Guidelines'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                '   The Traceback app is a platform that allows users to report lost or found items within the University of Porto campus. '
                'Its main objective is to connect users who have lost or found items with other users who may have found or lost the same items.\n'
                '   To use the Traceback app, users must create an account by signing up and providing personal information, such as their name, university email, phone number, and password. '
                'Once registered, users must accept the apps privacy and responsibility terms to gain access to all the available features. '
                'If users already have an account, they can log in using their name and registered email.\n'
                '   If a user loses an item on campus and wants to find it, they can create a post in the Traceback app. '
                'The post should contain a detailed description of the item, the title, category, multiple tags, the exact location where the item was last seen, the date of loss, and a photo of the item. '
                'This information will help other users who may have found the item to identify it and return it to its rightful owner.\n'
                '   If a user finds an item on campus, they can create a post in the Traceback app to report the found item. '
                'The post should include a detailed description of the item, the title, category, multiple tags, the exact location where the item was found, the date of the find, and a photo of the item. '
                'This information will help other users who may have lost the item to identify it and claim it.\n'
                '   Users can search for lost or found items in the Traceback app by using the search options available, such as categories, tags, etc. '
                'This makes it easier for users to locate items that match their description and increase the chances of finding them.\n'
                '   If a user finds an item that matches a reported loss in the Traceback app, they can contact the owner of the item using the information provided in the post.'
                'However, users should exercise caution and follow safety guidelines when contacting other users they do not know.\n'
                '   The Traceback app takes user privacy seriously and adopts security measures to protect user data. '
                'Users can control the privacy of their profile information and contact data to safeguard their personal information.\n'
                '   The Traceback app has clear terms of use and privacy policies that users should read before using the app. '
                'Users can contact the support team with any questions or concerns they may have about the app.\n'
                '   Users can provide feedback on the Traceback app by reporting bugs, usability issues, and suggesting improvements. '
                'This feedback helps the development team to improve the apps functionality and user experience.\n'
                '   The Traceback app is a useful platform for finding lost items on the University of Porto campus. '
                'By following these guidelines, users can maximize their chances of finding their lost items and help others to retrieve theirs.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

