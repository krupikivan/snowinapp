import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snowin/src/models/message.dart';
import 'package:snowin/src/widgets/bubble_chat.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.message, this.animationController, this.fecha});
  final Message message;
  final AnimationController animationController;
  final String fecha;
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
            Text(_parseDate(), style: Theme.of(context).textTheme.headline5),
            Text(
              message.mensaje,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

  _parseDate() {
    var dt = DateTime.parse(fecha);
    var hora = DateFormat('hh:mm').format(dt);
    var date = DateFormat('dd/MM').format(dt);
    return '$date  $hora';
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
