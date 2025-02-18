import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';

class CustomAppbar extends StatelessWidget {
  final BuildContext context;
  final String image;
  final double height;
  final bool back;
  final title;

  CustomAppbar({
    @required this.context,
    @required this.image,
    @required this.height,
    this.back = false,
    this.title = "",
  });

  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;
    final conex = Provider.of<ConnectionStatus>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      width: size.width,
      height: height,
      child: Stack(
        children: [
          // conex.status == Status.HasConnection ?
          CachedNetworkImage(
            width: double.infinity,
            height: 70,
            imageUrl: image,
            fit: BoxFit.cover,
          ),
          // : SizedBox(),
          Container(
            height: 70,
            color: Color.fromRGBO(74, 74, 73, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                back
                    ? Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        width: 35.0,
                      ),
                (title != "")
                    ? Container(
                        child: AutoSizeText(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              height: 60,
                              image: AssetImage("assets/images/logopng.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'SNOW',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300)),
                                TextSpan(
                                    text: 'IN',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ]),
                            )
                          ],
                        ),
                      ),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
