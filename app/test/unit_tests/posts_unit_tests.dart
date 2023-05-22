import 'package:TraceBack/posts/post_pages/post_page.dart';
import 'package:TraceBack/posts/timeline_util/short_post.dart';
import 'package:TraceBack/posts/main_timeline.dart';
import 'package:TraceBack/posts/post_pages/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets('Short Post Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PostCard(
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
}