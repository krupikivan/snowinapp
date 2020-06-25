import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:photo_view/photo_view.dart';

import '../../widgets/custom_appbar.dart';

class PistesMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              CustomAppbar(
                context: context,
                image: "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                height: 70.0,
                back: true,
              ),
              Positioned(
                top: 70.0,
                left: 0.0,
                right: 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: (size.height*0.4)-70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: AutoSizeText("Las pistas que recomendamos según tu experiencia son", style: TextStyle(fontSize: 15 ), maxLines: 2,)
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    AutoSizeText("CAMINO", style: TextStyle(fontSize: 15), maxLines: 2,),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    AutoSizeText("PIONERS, EL PALITO, LA SILLA, DE LA PRADERA", style: TextStyle(fontSize: 15), maxLines: 2,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      height: (size.height*0.6)-70,
                      child: PhotoView(
                        imageProvider: NetworkImage("https://www.willflyforfood.net/wp-content/uploads/2017/12/oak-valley-snow-park-trail-map.jpg"),
                        //imageProvider: NetworkImage("https://www.willflyforfood.net/wp-content/uploads/2017/12/oak-valley-snow-park-trail-map.jpg"),
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}