import 'package:flutter/material.dart';
import '../found_post/create_found_post.dart';
import '../timeline.dart';

class DescriptionField extends StatefulWidget {

  late TextEditingController controller;

  DescriptionField({
    required this.controller,
    super.key,
  });

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
          border: border(mainColor),
          focusedBorder: border(mainColor),
          enabledBorder: border(mainColor),
          label: Text("Description"),
          fillColor: grey,
          filled: true
      ),
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              ScrollController _scrollController = ScrollController();
              TextEditingController tempController = TextEditingController();
              tempController.text = widget.controller.text;
              return GestureDetector(
                onTap: (){FocusScope.of(context).unfocus();},
                child: AlertDialog(
                  title: Text("Description"),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Scrollbar(
                          controller: _scrollController,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: tempController,
                            scrollController: _scrollController,
                            autofocus: true,
                            autocorrect: true,
                            decoration: InputDecoration(
                                border: border(mainColor),
                                focusedBorder: border(mainColor)
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: (){
                            setState(() {
                              widget.controller.text = tempController.text;
                            });
                            Navigator.of(context).pop();
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(mainColor)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}