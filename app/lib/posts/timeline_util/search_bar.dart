import 'package:flutter/material.dart';

import '../main_timeline.dart';
import 'filter.dart';

class SearchBar extends StatefulWidget{

  final ItemsFilter filter;
  final Function search;
  final TextEditingController controller;

  SearchBar({
    super.key,
    required this.filter,
    required this.search,
    required this.controller
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 5),
        Expanded(
          child: Container(
              height: 40,
              child: TextField(
                onSubmitted: (value){
                  final FocusScopeNode currentScope = FocusScope.of(context);
                  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                  widget.filter.setSearchQuery(widget.controller.text);
                  widget.search();
                },
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                    fontSize: 17
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: accent,
                  labelText: "search",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: mainColor,
                          width: 2,
                          style: BorderStyle.solid
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                          color: mainColor,
                          width: 1,
                          style: BorderStyle.solid
                      )
                  ),
                  suffixIconColor: mainColor,
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    icon: Icon(Icons.close, size: 20,),
                    onPressed: (){
                      setState(() {
                        widget.controller.text = "";
                        final FocusScopeNode currentScope = FocusScope.of(context);
                        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      });
                    },
                  ),
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: mainColor,
            child: IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
                widget.filter.setSearchQuery(widget.controller.text);
                widget.search();
              },
            ),
          ),
        ),
      ],
    ),
  );
}