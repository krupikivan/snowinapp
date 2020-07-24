import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snowin/src/models/message.dart';
import 'package:snowin/src/widgets/bubble_chat.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.message, this.animationController, this.fecha, this.myMessage});
  final Message message;
  final AnimationController animationController;
  final String fecha;
  final bool myMessage;
  BubbleStyle styleSomebody;
  BubbleStyle styleMe;

  TextStyle textMy;
  TextStyle textSome;
  TextStyle styleMessage;

  @override
  Widget build(BuildContext context) {
    _messageStyle(context);
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Bubble(
        style: myMessage ? styleMe : styleSomebody,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_parseDate(), style: myMessage ? textMy : textSome),
            Text(
              message.mensaje,
              style: myMessage
                  ? styleMessage
                  : styleMessage.copyWith(color: Colors.grey[600]),
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
      color: Color.fromRGBO(208, 235, 250, 1),
      elevation: 1 * px,
      radius: Radius.circular(15),
      padding: BubbleEdges.all(15),
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    //If message is from me
    styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Theme.of(context).primaryColor,
      elevation: 1 * px,
      radius: Radius.circular(15),
      padding: BubbleEdges.all(15),
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    textMy = TextStyle(
      fontFamily: 'RobotoCondensed',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xff72bfff),
    );

    styleMessage = TextStyle(
      fontFamily: 'RobotoCondensed',
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    textSome = TextStyle(
      fontFamily: 'RobotoCondensed',
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: Colors.grey[600],
    );
  }
}
