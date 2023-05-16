import 'package:flutter/material.dart';
import '../posts/main_timeline.dart';
import 'package:TraceBack/util/colors.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 80,
        title: Text('Terms of Privacy and Responsibility'),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: (){Navigator.of(context).pop();},
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Privacy Policy\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '   This Privacy Policy explains how we collect, use, and protect information about you when you use our app.'
                'By using our service, you consent to the collection, use, and disclosure of your information as described in this Privacy Policy.\n'
                '   We may collect the following information from you when you use our app:\n'
                '- Personal Information: We may collect personal information such as your name, email address, phone number, and billing information.\n'
                '- Usage Information: We may collect usage information about how you use our app, such as the pages you visit, the features you use, and the time you spend on the app.\n'
                '- Device Information: We may collect device information such as your device type, operating system, and browser type.\n'
                '   We take reasonable measures to protect your information from unauthorized access, use, or disclosure.'
                'However, no method of transmission over the internet or electronic storage is 100% secure.\n'
                'We may update this Privacy Policy from time to time.'
                'If we make material changes, we will provide notice by posting a notice on our app or by other means.\n',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Responsibility Policy\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '   You agree to use TraceBack in compliance with applicable laws and regulations.'
                'You are responsible for maintaining the confidentiality of your account information and for any activities that occur under your account.'
                'We are not responsible for any unauthorized access to your account or any loss or damage that may result from your failure to comply with this responsibility.\n'
                '   You are solely responsible for any content or information that you submit or transmit through our app.'
                'You warrant that you have all necessary rights to submit or transmit such content or information and that it does not infringe the intellectual property rights or privacy rights.\n'
                '   You agree to indemnify and hold us harmless from any claims, damages, or other liabilities arising from your use of our app or any content or information that you submit or transmit through our app.\n'
                'We reserve the right to suspend or terminate your access to our app at any time, without notice, for any reason, including, but not limited to, any violation of these terms or any applicable law or regulation.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      drawer: SideMenu(),
    );
  }
}
