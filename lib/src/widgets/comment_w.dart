import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:snowin/src/utils/app_localization.dart';

class CommentW extends StatefulWidget {
  final String title;
  final AfterCommentCallback afterComment;

  CommentW({Key key, this.title = 'Comenta', this.afterComment})
      : super(key: key);

  @override
  CommentWState createState() => new CommentWState(title);
}

class CommentWState extends State<CommentW> {
  String title;

  CommentWState(this.title);

  TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          AutoSizeText(title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Color.fromRGBO(74, 74, 73, 1)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixStyle: TextStyle(color: Colors.black, fontSize: 18),
                hintText: 'Comenta',
                hintStyle: TextStyle(color: Colors.black, fontSize: 18),
              ),
              style: TextStyle(fontSize: 18),
              maxLength: 700,
              maxLines: 5,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: RaisedButton(
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: AutoSizeText(
                    _t(context, "cancel").toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      Navigator.pop(context);
                      widget.afterComment(controller.text);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: AutoSizeText(
                    _t(context, "send").toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _t(BuildContext context, String label) {
    return AppLocalizations.of(context).translate(label);
  }
}

typedef AfterCommentCallback = void Function(String value);
