import 'package:TraceBack/posts/timeline_util/short_post.dart';
import 'package:TraceBack/posts/main_timeline.dart';
import 'package:TraceBack/posts/post_pages/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class PostMock extends Post {

  PostMock({required super.tags, required super.title, required super.location, required super.imageRetriever, required super.date, required super.description, required super.authorID});

  @override
  State<Post> createState() => _MockPostState();
}

class _MockPostState extends PostState {

  @override
  loadAuthor() {
    authorName = "Test Author Name";
  }

  @override
  loadMap() {
    map = Container();
  }

  @override
  loadPhoto() {
    photo = Container();
  }
}

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

  testWidgets('Post Widget Test', (WidgetTester tester) async {

    imageRetriever() async {
      return Image.asset("assets/images/TraceBack.png");
    }

    await tester.pumpWidget(MaterialApp(
      home: Column(
        children: [PostMock(
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

    await tester.pumpAndSettle();

    expect(find.text("Test Title"), findsOneWidget);
    expect(find.text("Test Date"), findsOneWidget);
    expect(find.byType(Tag), findsNWidgets(2));
    expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    expect(find.text("Test Description"), findsOneWidget);
    expect(find.text("FEUP Porto"), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
  });
}