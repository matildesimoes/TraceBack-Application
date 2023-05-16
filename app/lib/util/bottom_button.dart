import 'package:TraceBack/util/colors.dart';
import 'package:flutter/material.dart';


class BottomButton extends StatelessWidget {

  final String text;
  final Function onPressed;
  final IconData icon;

  const BottomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
                color: mainColor,
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)]
              ),
              width: constraints.maxWidth,
              height: 100,
            ),
        ),
        SizedBox(
          height: 60,
          width: 200,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              backgroundColor: secondaryColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            onPressed: (){onPressed();},
            icon: Icon(icon, color: Colors.white, size: 23,),
            label: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ]
    );
  }
}