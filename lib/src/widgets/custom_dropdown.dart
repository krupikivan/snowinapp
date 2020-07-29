import 'package:flutter/material.dart';
import 'package:snowin/src/models/item_kv.dart';

class CustomDropdownd extends StatefulWidget {
  final double width;
  final double height;
  final String prefix;
  final List<ItemKV> items;
  final value;
  final OnChangedCallback onChanged;
  final bool error;
  final bool disabled;
  final String replaceFirst;

  CustomDropdownd(
      {Key key,
      this.width,
      this.height,
      this.prefix,
      this.items,
      this.value,
      this.onChanged,
      this.error = false,
      this.replaceFirst = '',
      this.disabled = false})
      : super(key: key);

  @override
  CustomDropdowndState createState() => new CustomDropdowndState(
      width, height, prefix, items, value, error, replaceFirst);
}

class CustomDropdowndState extends State<CustomDropdownd> {
  double width;
  double height;
  String prefix;
  List<ItemKV> items;
  var value;
  bool error;
  String replaceFirst;

  CustomDropdowndState(this.width, this.height, this.prefix, this.items,
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
              items: items.map((ItemKV item) {
                String value =
                    (item.key.toString().isEmpty && replaceFirst.isNotEmpty)
                        ? replaceFirst
                        : item.value.toString();
                return DropdownMenuItem<String>(
                  value: item.key.toString(),
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
                return items.map<Widget>((ItemKV item) {
                  String value =
                      (item.key.toString().isEmpty && replaceFirst.isNotEmpty)
                          ? replaceFirst
                          : item.value.toString();
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
              disabledHint: RichText(
                text: TextSpan(children: [
                  TextSpan(text: "   "),
                  TextSpan(
                    text: prefix,
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  ),
                ]),
              ),
              hint: RichText(
                text: TextSpan(children: [
                  TextSpan(text: "   "),
                  TextSpan(
                    text: prefix,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ]),
              ),
              onChanged: widget.disabled
                  ? null
                  : (val) {
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
