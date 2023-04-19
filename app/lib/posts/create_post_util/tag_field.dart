import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../timeline.dart';
import '../found_post/create_found_post.dart';

class TagField extends StatelessWidget {

  TagField({
    super.key,
    required this.controller
  });

  double? _distanceToField;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextfieldTagsController controller;

  @override
  Widget build(BuildContext context) {
    _distanceToField = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: TextFieldTags(
        key: formKey,
        textfieldTagsController: controller,
        textSeparators: const [' ', ','],
        letterCase: LetterCase.normal,
        validator: (String tag) {
          if (controller.getTags!.contains(tag)) {
            return 'you already entered that';
          }
          return null;
        },
        inputfieldBuilder:
            (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, sc, tags, onTagDelete) {
            return TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: accent,
                enabledBorder: border(mainColor),
                focusedBorder: border(mainColor),
                errorBorder:border(Colors.red),
                focusedErrorBorder: border(Colors.red),
                hintText: controller.hasTags ? '' : "Enter tag...",
                errorText: error,
                prefixIconConstraints:
                BoxConstraints(maxWidth: _distanceToField! * 0.74),
                prefixIcon: tags.isNotEmpty
                    ?
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: tags.map((String tag) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: mainColor,
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '#$tag',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(
                                        255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                  ),
                )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            );
          });
        },
      ),
    );
  }
}