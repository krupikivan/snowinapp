import 'package:flutter/material.dart';
import 'package:snowin/src/models/item_kv.dart';

class CustomDropdowndString extends StatefulWidget {
  final double width;
  final double height;
  final String prefix;
  final List items;
  final value;
  final OnChangedCallback onChanged;
  final bool error;
  final String replaceFirst;

  CustomDropdowndString(
      {Key key,
      this.width,
      this.height,
      this.prefix,
      this.items,
      this.value,
      this.onChanged,
      this.error = false,
      this.replaceFirst = ''})
      : super(key: key);

  @override
  CustomDropdowndStringState createState() => new CustomDropdowndStringState(
      width, height, prefix, items, value, error, replaceFirst);
}

class CustomDropdowndStringState extends State<CustomDropdowndString> {
  double width;
  double height;
  String prefix;
  List items;
  var value;
  bool error;
  String replaceFirst;

  CustomDropdowndStringState(this.width, this.height, this.prefix, this.items,
      this.value, this.error, this.replaceFirst);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: (error && value.toString().isEmpty)
                      ? Colors.red
                      : Color.fromRGBO(74, 74, 73, 1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            padding: EdgeInsets.only(top: 12.0),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: (error && value.toString().isEmpty)
                    ? Colors.red
                    : Color.fromRGBO(74, 74, 73, 1),
                size: 35,
              ),
              value: value,
              items: items.map((var item) {
                String value = (item.isEmpty && replaceFirst.isNotEmpty)
                    ? replaceFirst
                    : item;
                return DropdownMenuItem<String>(
                  value: item,
                  child: RichText(
                      text: TextSpan(
                          text: value,
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((var item) {
                  String value = (item.isEmpty && replaceFirst.isNotEmpty)
                      ? replaceFirst
                      : item;
                  return RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "   "),
                      TextSpan(
                        text: prefix,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      TextSpan(text: "  "),
                      TextSpan(
                        text: value,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ]),
                  );
                }).toList();
              },
              hint: RichText(
                text: TextSpan(children: [
                  TextSpan(text: "   "),
                  TextSpan(
                    text: prefix,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ]),
              ),
              onChanged: (val) {
                widget.onChanged(val);
                setState(() {
                  value = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnChangedCallback = void Function(String value);
