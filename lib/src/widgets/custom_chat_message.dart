import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snowin/src/widgets/bubble_chat.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.name});
  final String text;
  final AnimationController animationController;
  final String name;
  BubbleStyle styleSomebody;
  BubbleStyle styleMe;

  @override
  Widget build(BuildContext context) {
    _messageStyle(context);
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Bubble(
        style: styleMe,
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hoy ${DateFormat('HH:mm').format(DateTime.now())}',
                style: Theme.of(context).textTheme.headline5),
            Text(
              text,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

  //-----------------------Styling message-----------------------
  _messageStyle(BuildContext context) {
    final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final double px = 1 / pixelRatio;
    //If message is from the other side
    styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      radius: Radius.circular(15),
      padding: BubbleEdges.all(15),
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    //If message is from me
    styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      radius: Radius.circular(15),
      padding: BubbleEdges.all(15),
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
  }
}
