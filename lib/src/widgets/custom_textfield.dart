import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final bool readOnly;
  final String prefix;
  final String hint;
  final int maxLength;
  final int maxLines;
  final OnChangedCallback onChanged;
  final bool error;
  final bool onlyDigits;

  CustomTextField(
      {this.controller,
      this.width,
      this.readOnly = false,
      this.prefix = '',
      this.hint = '',
      this.maxLength,
      this.maxLines = 1,
      this.onChanged,
      this.onlyDigits = false,
      this.error = false});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: error ? Colors.red : Color.fromRGBO(74, 74, 73, 1)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                onlyDigits
                    ? WhitelistingTextInputFormatter.digitsOnly
                    : WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]"))
              ],
              keyboardType:
                  onlyDigits ? TextInputType.number : TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                labelText: prefix,
                border: InputBorder.none,
                prefixStyle: TextStyle(color: Colors.black, fontSize: 18),
                hintStyle: TextStyle(color: Colors.black, fontSize: 18),
              ),
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              readOnly: readOnly,
              maxLength: maxLength,
              maxLines: maxLines,
              onChanged: (val) {
                onChanged(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnChangedCallback = void Function(String value);
