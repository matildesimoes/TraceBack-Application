import 'package:TraceBack/posts/short_post.dart';
import 'package:TraceBack/posts/timeline.dart';
import 'package:TraceBack/posts/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets('Short Post Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ShortPost(
        title: "Test Title",
        date: "Test Date",
        tags: "Tag1,Tag2",
        location: "Test Location",
        description: "Test Description",
        authorID: "Test Author ID",
        imageURL: 'null',
        postID: 'null',
        isLostPost: false,
        isClosed: false,
      ),
    ));

    expect(find.text("Test Title"), findsOneWidget);
    expect(find.text("Test Date"), findsNothing);
    expect(find.byType(Tag), findsNWidgets(2));
    expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    expect(find.byType(Image), findsNothing);
    expect(find.text("Test Location"), findsOneWidget);
    expect(find.text("Test Description"), findsNothing);
    expect(find.text("Test Author ID"), findsNothing);
  });

  testWidgets('Post Widget Test', (WidgetTester tester) async {

    imageRetriever() async {
      return Image.asset("assets/images/TraceBack.png");
    }

    await tester.pumpWidget(MaterialApp(
      home: Column(
        children: [Post(
          title: "Test Title",
          date: "Test Date",
          tags: [Tag("Tag1"), Tag("Tag2")],
          location: "FEUP Porto",
          description: "Test Description",
          authorID: "Test Author ID",
          imageRetriever: imageRetriever ,
        ),]
      ),
    ));

    expect(find.text("Test Title"), findsOneWidget);
    expect(find.text("Test Date"), findsOneWidget);
    expect(find.byType(Tag), findsNWidgets(2));
    expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    expect(find.text("Test Description"), findsOneWidget);
    expect(find.text("FEUP Porto"), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
  });
}