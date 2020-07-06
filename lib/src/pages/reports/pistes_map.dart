import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:photo_view/photo_view.dart';

import 'package:snowin/src/utils/session.dart';

import 'package:snowin/src/models/ski_center.dart';
import 'package:snowin/src/models/pist.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';



class PistesMap extends StatefulWidget {
  @override
  _PistesMapState createState() => _PistesMapState();
}

class _PistesMapState extends State<PistesMap> {
  Session _session = new Session();

  TextEditingController _controllerYouAre;
  SkiCenter _center;
  List<Pist> _recomendedTraks = List<Pist>();



  @override
  void initState() {
    super.initState();

    _controllerYouAre = TextEditingController();
    detalleCentroSki();
  }

  @override
  void dispose() {

    _controllerYouAre.dispose();

    super.dispose();
  }

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
                          SizedBox(height: 10,),
                          Container(
                            child: CustomTextField(width: size.width*0.9, prefix: "Estas en ", controller: _controllerYouAre, readOnly: true,),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: AutoSizeText("Las pistas que recomendamos según tu experiencia son", style: TextStyle(fontSize: 15 ), maxLines: 2,)
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Wrap(
                              children: buildRecomendedTraks(),
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





//////////////////////////////////////////////////////////////Functions
  Future<void> detalleCentroSki() async {
      SnowinProvider().detalleCentroSki(_session.center.id.toString())
                      .then((response) { print('detalle-centro-ski response: '); print(response);
                          if(response['ok']) {
                              var data = response['data'];

                              setState(() {
                                  _center = data['centro_ski'] != null? SkiCenter.map(data['centro_ski']) : SkiCenter(0, 'No hay centro', 0.0, 0.0, []);
                                  _recomendedTraks = List<Pist>();
                                  if(data['pistas_recomendadas'] != null) {
                                    final _castDataType = data['pistas_recomendadas'].cast<Map<String, dynamic>>();
                                    _recomendedTraks = _castDataType.map<Pist>((json) => Pist.map(json)).toList();
                                  }
                                  _controllerYouAre.text = _center.name;
                              });
                          } else {
                              throw new Exception('Error');
                          }
                      }).catchError((error) {
                          print(error.toString());
                      });
  }

  List<Widget> buildRecomendedTraks() {
    List<Widget> elements = new List<Widget>();

    elements.add(SizedBox(height: 5,));

    _recomendedTraks.forEach((element) {
        elements.add(Row(
                        children: [
                            // Container(
                            //     height: 15,
                            //     width: 15,
                            //     decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Colors.green,
                            //     ),
                            // ),
                            SizedBox(width: 10,),
                            AutoSizeText(element.descripcion.toString().trim(), style: TextStyle(fontSize: 15), maxLines: 2,),
                        ]));
        elements.add(SizedBox(height: 5,));
    });

    return elements;
  }

}