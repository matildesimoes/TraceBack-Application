import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'main.dart';
import 'map.dart';

class CreateFoundPost extends StatefulWidget {
  const CreateFoundPost({Key? key}) : super(key: key);

  @override
  State<CreateFoundPost> createState() => _CreateFoundPostState();
}

class _CreateFoundPostState extends State<CreateFoundPost> {

  List<String> tags = [];

  TextEditingController textFieldController = new TextEditingController();

  var _dateController = TextEditingController(
    text: DateTime.now().day.toString() + "/" +
        DateTime.now().month.toString() + "/" +
        DateTime.now().year.toString()
  );

  void _showDatePicker() {
    showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: mainColor),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _dateController.text =
            (value!).day.toString() + "/" +
            (value!).month.toString() + "/" +
            (value!).year.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "Post Found Item",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            backgroundColor: mainColor,
            toolbarHeight: 80,
          ),
          drawer: SideMenu(),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      label: Text("Title"),
                    filled: true,
                    fillColor: grey,
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropDownTextField(
                  textFieldDecoration: InputDecoration(
                      label: Text("Category"),
                    filled: true,
                    fillColor: grey,
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
                  ),
                  dropDownList: [
                    DropDownValueModel(name: 'All', value: "All"),
                    DropDownValueModel(name: 'IT Devices', value: "IT Devices"),
                    DropDownValueModel(name: 'Keys', value: "Keys"),
                    DropDownValueModel(name: 'Clothing', value: "Clothing"),
                    DropDownValueModel(name: 'School Supplies', value: "School Supplies"),
                    DropDownValueModel(name: 'Other', value: "Other"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldTags(

                  tagsDistanceFromBorderEnd: 1,
                  textSeparators: [
                    " ", //seperate with space
                    ',', //sepearate with comma as well
                    ";"
                  ],
                  initialTags: tags,
                  onTag: (tag){
                    //this will give tag when entered new single tag
                    tags.add(tag);
                  },
                  onDelete: (tag){
                    //this will give single tag on delete
                    tags.remove(tag);
                  },
                  validator: (tag){
                    //add validation for tags
                    if(tag.length < 3){
                      return "Enter tag up to 3 characters.";
                    }
                    return null;
                  },
                  tagsStyler: TagsStyler( //styling tag style
                      tagTextStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
                      tagDecoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20.0), ),
                      tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.white),
                      tagPadding: EdgeInsets.all(6.0),
                  ),
                  textFieldStyler: TextFieldStyler(
                    helperText: "Enter Tags",
                    textFieldBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: "Tags",
                    textFieldFilled: true,
                    textFieldFilledColor: grey,
                    textFieldFocusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textFieldEnabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    new TextEditingController().clear();
                  },
                  child: TextFormField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                      label: Text("Location"),
                      hintText: "Select location >",
                      suffixIcon: IconButton(
                          onPressed: _getLocation,
                          icon: Icon(Icons.location_on, color: mainColor)
                      ),
                      filled: true,
                      fillColor: grey,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    _dateController.clear();
                  },
                  child: TextFormField(
                    readOnly: true,
                    controller: _dateController,
                    decoration: InputDecoration(
                      label: Text("Date"),
                      hintText: "Click calendar >",
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showDatePicker();
                        },
                        icon: Icon(Icons.calendar_month, color: mainColor),
                      ),
                      filled: true,
                      fillColor: grey,
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
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextButton.icon(
                    onPressed: (){},
                    label: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    icon: Icon(Icons.post_add, color: Colors.white,),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(mainColor),                   ),
                  ),
                ),
              ],
            ),
          )
      );
  }

  void _getLocation() async {
    final location = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Map())
    );
    textFieldController.text = location;
  }
}
