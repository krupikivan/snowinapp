import 'package:flutter/material.dart';

import 'custom_num_data.dart';

class CustomRowData extends StatelessWidget {
  const CustomRowData(
      {Key key,
      this.title1,
      this.title2,
      this.title3,
      this.num1,
      this.num2,
      this.num3})
      : super(key: key);
  final String title1;
  final String title2;
  final String title3;
  final int num1;
  final int num2;
  final int num3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomNumData(
                title: title1,
                number: num1,
              ),
              Container(
                width: 1,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.grey,
              ),
              CustomNumData(
                title: title2,
                number: num2,
              ),
              Container(
                width: 1,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.grey,
              ),
              CustomNumData(
                title: title3,
                number: num3,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 1,
            indent: 16,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
