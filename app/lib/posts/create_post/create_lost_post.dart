import 'package:TraceBack/posts/create_post/create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../profile/profileBackend.dart';
import '../post_pages/post_preview_page.dart';
import '../posts_backend/posts_backend.dart';

class CreateLostPost extends CreatePost{
  const CreateLostPost({super.key});

  @override
  State<CreatePost> createState() => _CreateLostPostState();
}

class _CreateLostPostState extends CreatePostState {

  @override
  String get title => "Post Lost Item";

  @override
  PostsBackend get backend => LostBackend();

  @override
  preview() async {
    FocusScope.of(context).unfocus();
    if (formkey.currentState!.validate()) {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  PostPreview(
                    tags: tagsController.hasTags ?
                    tagsController.getTags.toString().substring(
                        1,
                        tagsController.getTags
                            .toString()
                            .length - 1
                    ) : "",
                    category: categoryController.dropDownValue!.value,
                    title: titleController.text,
                    location: locationController.text,
                    date: dateController.text,
                    image: image,
                    description: descriptionController.text,
                    authorID: ProfileBackend().getCurrentUserID(),
                    submit: submit,
                  )
          )
      );
    }
  }
}