import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:snowin/src/models/notifications.dart';

import 'package:snowin/src/pages/reports/widgets/time.dart';
import 'package:snowin/src/pages/reports/widgets/total_comments.dart';



class NotificationsTile extends StatefulWidget {
  final Notifications notifications;
  final int index;
  final AfterSendCallback afterSend;

  NotificationsTile({ Key key, this.notifications, this.index, this.afterSend}) : super(key: key);

  @override
  NotificationsTileState createState() => new NotificationsTileState(notifications, index);
}

class NotificationsTileState extends State<NotificationsTile> {
  Notifications notifications;
  int index;

  NotificationsTileState(this.notifications, this.index);



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
    final size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(vertical:5,),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: IconButton(
                        icon: Icon(Icons.message, size: 15.0,),
                        onPressed: () {
                        },
                      ),
                    ),
                    _avatar(notifications.image.toString(), size),
                    SizedBox(width: 10,),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              AutoSizeText(notifications.user.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color.fromRGBO(159, 159, 159, 1)),),
                              AutoSizeText(notifications.level.toString(), style: TextStyle(fontSize: 13),),
                          ],
                      ),
                    ),
                    Expanded(child: Container(), flex: 1),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: IconButton(
                        icon: Icon(Icons.message, size: 15.0,),
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Divider(height: 1.0, color: Colors.grey,),
            ],
          ),
      ),
      onTap: () {
      },
    );
  }

  Widget _avatar(String image, Size size) {
    return Container(
      width: 0.15*size.width,
      height: 0.15*size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover
        ),
      ),
    );
  }

}

typedef AfterSendCallback = void Function();

