import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:snowin/src/config/config.dart';

import 'package:snowin/src/models/user.dart';



class FriendTileList extends StatefulWidget {
  final User friend;
  final AfterSendCallback afterSend;

  FriendTileList({ Key key, this.friend, this.afterSend}) : super(key: key);

  @override
  FriendTileListState createState() => new FriendTileListState(friend);
}

class FriendTileListState extends State<FriendTileList> {
  User friend;

  FriendTileListState(this.friend);



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
    String strAltitud = '';
    int _altitud = int.parse(friend.altura.toString());
    if(_altitud > 0) {
        double altitud = _altitud < 1000? (_altitud/1) : (_altitud/1000);
        strAltitud = 'A ' + altitud.toString() + (_altitud < 1000? ' mts' : ' km');
    }

    return InkWell(
      child: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(vertical:5,),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    _avatar(friend.image.toString(), size),
                    SizedBox(width: 10,),
                    Container(
                      width: 0.45 * size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              AutoSizeText(friend.username.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color.fromRGBO(159, 159, 159, 1)),),
                              AutoSizeText(friend.nivel.toString(), style: TextStyle(fontSize: 13),),
                          ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 0.14 * size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              AutoSizeText(strAltitud, textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(159, 159, 159, 1)),),
                          ],
                      ),
                    ),
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
        color: Colors.grey,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: image.isNotEmpty? NetworkImage(Config.apiImageBaseUrl + image) : Image.asset('assets/images/male.png').image,
          fit: BoxFit.cover
        ),
      ),
    );
  }

}

typedef AfterSendCallback = void Function();

