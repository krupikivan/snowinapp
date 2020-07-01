import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final Widget prev;
  final Widget next;
  final bool value;
  final OnChangedCallback onChanged;


  CustomCheckbox({
    this.prev,
    this.next,
    this.value = false,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget> [
            prev != null? prev : Container(),
            Checkbox(
                value: value,
                onChanged: (val) {
                    onChanged(val);
                },
            ),
            next != null? next : Container(),
        ]
    );
  }
}



typedef OnChangedCallback = void Function(bool value);
