import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/models/pist.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import '../../widgets/custom_appbar_pages.dart';
import '../../widgets/custom_drawer.dart';

class PistesMap extends StatefulWidget {
  @override
  _PistesMapState createState() => _PistesMapState();
}

class _PistesMapState extends State<PistesMap> {
  // UserProvider _session = new UserProvider();

  TextEditingController _controllerYouAre;
  List<Pist> _recomendedTraks = List<Pist>();

  @override
  void initState() {
    super.initState();
    _controllerYouAre = TextEditingController();
  }

  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    _controllerYouAre.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final report = Provider.of<ReportProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppbarPages(
            scaffoldDrawer: scaffoldDrawer,
            back: true,
            context: context,
            title: "MAPA DE PISTAS",
          ),
          preferredSize: Size(double.infinity, 70)),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomTextField(
                    width: size.width * 0.9,
                    prefix: "Estas en ",
                    controller: _controllerYouAre,
                    readOnly: true,
                  ),
                  AutoSizeText(
                    "Las pistas que recomendamos según tu experiencia son",
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      children: buildRecomendedTraks(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: true,
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              imageProvider: NetworkImage(
                  "https://www.willflyforfood.net/wp-content/uploads/2017/12/oak-valley-snow-park-trail-map.jpg"),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildRecomendedTraks() {
    List<Widget> elements = new List<Widget>();

    elements.add(SizedBox(
      height: 5,
    ));

    _recomendedTraks.forEach((element) {
      elements.add(Row(children: [
        // Container(
        //     height: 15,
        //     width: 15,
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.green,
        //     ),
        // ),
        SizedBox(
          width: 10,
        ),
        AutoSizeText(
          element.descripcion.toString().trim(),
          style: TextStyle(fontSize: 15),
          maxLines: 2,
        ),
      ]));
      elements.add(SizedBox(
        height: 5,
      ));
    });
    return elements;
  }
}
