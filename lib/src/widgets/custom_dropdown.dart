import 'package:flutter/material.dart';

class CustomDropdownd extends StatelessWidget {

  final double width;
  final double height;
  final String label;

  CustomDropdownd({
    this.width,
    this.height,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(74, 74, 73, 1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              icon: Icon(Icons.keyboard_arrow_down, color: Color.fromRGBO(74, 74, 73, 1), size: 35,),
              onChanged: (val){},
              hint: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "   "),
                    TextSpan(
                      text: label,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    TextSpan(text: "  "),
                    TextSpan(
                      text: 'Chapelco',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ]
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 1,
                  onTap: (){},
                  child: Text("Opcion 1"),
                ),
                DropdownMenuItem(
                  value: 2,
                  onTap: (){},
                  child: Text("Opcion 2"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
