import 'package:flutter/material.dart';
import 'package:snowin/src/models/item_kv.dart';



class CustomMoodDropdownd extends StatefulWidget {

  final double width;
  final double height;
  final String prefix;
  final List<ItemKV> items;
  final value;
  final OnChangedCallback onChanged;
  final bool error;
  final String replaceFirst;

  CustomMoodDropdownd({ Key key, this.width, this.height, this.prefix, this.items, this.value, this.onChanged, this.error = false, this.replaceFirst = ''}) : super(key: key);

  @override
  CustomMoodDropdowndState createState() => new CustomMoodDropdowndState(width, height, prefix, items, value, error, replaceFirst);
}

class CustomMoodDropdowndState extends State<CustomMoodDropdownd> {
  double width;
  double height;
  String prefix;
  List<ItemKV> items;
  var value;
  bool error;
  String replaceFirst;

  CustomMoodDropdowndState(this.width, this.height, this.prefix, this.items, this.value, this.error, this.replaceFirst);


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
                  color: (error && value.toString().isEmpty)? Colors.red : Color.fromRGBO(74, 74, 73, 1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            padding: EdgeInsets.only(top: 0.0),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              icon: Icon(Icons.keyboard_arrow_down, color: (error && value.toString().isEmpty)? Colors.red : Color.fromRGBO(74, 74, 73, 1), size: 35,),
              value: value,
              items: items.map((ItemKV item) {
                  String value = (item.key.toString().isEmpty && replaceFirst.isNotEmpty)? replaceFirst : item.value.toString();
                  IconData iconData;
                  bool dataIcon = true;
                  switch(item.key.toString()){
                      case 'BUENA':
                            iconData = Icons.insert_emoticon;
                            break;
                      case 'REGULAR':
                            iconData = Icons.sentiment_neutral;
                            break;
                      case 'MALA':
                            iconData = Icons.mood_bad;
                            break;
                      default:
                            dataIcon = false;
                            break;
                  }

                  return  DropdownMenuItem<String>(
                      value: item.key.toString(),
                      child: dataIcon?
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(width:10.0),
                                            Icon(iconData, color: primaryColor, size: 25,),
                                            SizedBox(width:10.0),
                                            RichText(
                                                text: TextSpan(
                                                    text: value,
                                                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18)
                                                )
                                            )
                                          ],
                                      )
                                      :
                                      RichText(
                                          text: TextSpan(
                                              text: value,
                                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18)
                                          )
                                      ),
                  );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                  return items.map<Widget>((ItemKV item) {
                      String value = (item.key.toString().isEmpty && replaceFirst.isNotEmpty)? replaceFirst : item.value.toString();
                      IconData iconData;
                      bool dataIcon = true;
                      switch(item.key.toString()){
                          case 'BUENA':
                                iconData = Icons.insert_emoticon;
                                break;
                          case 'REGULAR':
                                iconData = Icons.sentiment_neutral;
                                break;
                          case 'MALA':
                                iconData = Icons.mood_bad;
                                break;
                          default:
                                dataIcon = false;
                                break;
                      }

                      return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('   ' + prefix + '  ', style: TextStyle(color: Colors.black, fontSize: 18)),
                            dataIcon?
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(width:10.0),
                                            Icon(iconData, color: primaryColor, size: 25,),
                                            SizedBox(width:10.0),
                                            RichText(
                                                text: TextSpan(
                                                    text: value,
                                                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18)
                                                )
                                            )
                                          ],
                                      )
                                      :
                                      RichText(
                                          text: TextSpan(
                                              text: value,
                                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18)
                                          )
                                      ),
                          ],
                      );
                  }).toList();
              },
              hint: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "   "),
                    TextSpan(
                      text: prefix,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ]
                ),
              ),
              onChanged: (val){
                  widget.onChanged(val);
                  setState(() { value = val; });
              },
            ),
          ),
        ],
      ),
    );
  }
}



typedef OnChangedCallback = void Function(String value);
