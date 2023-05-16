import 'package:flutter/material.dart';
import 'package:TraceBack/util/colors.dart';

import 'filter.dart';

class CategoryBar extends StatefulWidget {

  ItemsFilter filter;
  Function() search;
  final TextEditingController searchCtrl;

  CategoryBar({
    super.key,
    required this.filter,
    required this.search,
    required this.searchCtrl});

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  filterCategory(String category){
    widget.filter.setCategory(category);
    widget.search();
  }

  updateCategoryIndex(int index){
    setState(() {
      _categoryIndex = index;
      FocusScope.of(context).unfocus();
    });
  }

  int _categoryIndex = 0;

  List<String> categories = [
    "All", "IT Devices", "Keys", "Clothing", "School Supplies", "Other"
  ];

  @override
  Widget build(BuildContext context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
      child: ListView.builder (
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool active = index == _categoryIndex;
          return Category(
            categories[index],
            filterCategory: filterCategory,
            index: index,
            active: active,
            updateIndex: updateCategoryIndex,
          );
        },
        itemCount: categories.length,
      )
  );
}

class Category extends StatefulWidget{

  final String text;
  final Function filterCategory;
  final int index;
  final bool active;
  final Function updateIndex;

  const Category(
      this.text, {
        super.key,
        required this.filterCategory,
        required this.index,
        required this.active,
        required this.updateIndex
      }
      );

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
    child: TextButton(
      onPressed: (){
        widget.updateIndex(widget.index);
        widget.filterCategory(widget.text);
      },
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            widget.active ? secondaryColor : mainColor
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            )
        ),
      ),
    ),
  );
}