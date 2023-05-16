import 'package:TraceBack/posts/create_post/create_post.dart';
import 'package:TraceBack/posts/posts_backend/posts_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../profile/profileBackend.dart';
import '../main_timeline.dart';
import '../post_pages/post_preview_page.dart';

class CreateFoundPost extends CreatePost{
  const CreateFoundPost({super.key});

  @override
  State<CreatePost> createState() => _CreateFoundPostState();
}

class _CreateFoundPostState extends CreatePostState {

  @override
  String get title => "Post Found Item";

  @override
  PostsBackend get backend => FoundBackend();

  @override
  preview() async {
    FocusScope.of(context).unfocus();
    if (formkey.currentState!.validate()) {
      if (image == null){
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: "Please upload a photo of the item",
            textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
            backgroundColor: secondaryColor,
          ),
        );
        return;
      }
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