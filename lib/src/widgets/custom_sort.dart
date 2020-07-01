import 'package:flutter/material.dart';



class CustomSort extends StatefulWidget {

  final double width;
  final double height;
  final String text;
  final bool value;
  final OnChangedCallback onChanged;

  CustomSort({ Key key, this.width, this.height, this.text, this.value = false, this.onChanged}) : super(key: key);

  @override
  CustomSortState createState() => new CustomSortState(width, height, text, value);
}

class CustomSortState extends State<CustomSort> {
  double width;
  double height;
  String text;
  bool value;

  CustomSortState(this.width, this.height, this.text, this.value);


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Color.fromRGBO(74, 74, 73, 1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            // padding: EdgeInsets.only(top: 12.0),
            child: ListTile(
                title: Text(text, style: TextStyle(color: Colors.black, fontSize: 18),),
                trailing: IconButton(
                    icon: Icon(value? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
                    onPressed: () {
                        value = !value;
                        widget.onChanged(value);
                        setState(() {});
                    }
                ),
            ),
          ),
        ],
      ),
    );
  }
}



typedef OnChangedCallback = void Function(bool value);
