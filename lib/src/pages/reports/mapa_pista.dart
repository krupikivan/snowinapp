import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import '../../widgets/custom_appbar_pages.dart';
import '../../widgets/custom_drawer.dart';

class MapaPista extends StatefulWidget {
  @override
  _MapaPistaState createState() => _MapaPistaState();
}

class _MapaPistaState extends State<MapaPista> {
  // UserProvider _session = new UserProvider();

  TextEditingController _controllerYouAre;

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
    _controllerYouAre.text = report.center.name;
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
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomTextField(
                    width: size.width * 0.9,
                    prefix: "Estas en ",
                    controller: _controllerYouAre,
                    readOnly: true,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.13),
                    child: AutoSizeText(
                      "Las pistas que recomendamos según tu experiencia son",
                      style: TextStyle(fontSize: 20),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Wrap(
                      children: buildRecomendedTraks(report),
                    ),
                  ),
                ],
              ),
            ),
          ),
          report.center.imagen != null
              ? Expanded(
                  flex: 3,
                  child: PhotoView(
                    minScale: PhotoViewComputedScale.contained * 1.5,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    enableRotation: true,
                    backgroundDecoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    imageProvider: NetworkImage(
                        Config.apiImageBaseUrl + report.center.imagen),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  List<Widget> buildRecomendedTraks(ReportProvider report) {
    List<Widget> elements = new List<Widget>();

    elements.add(SizedBox(
      height: 5,
    ));

    report.pistasRecomendadas.forEach((element) {
      elements.add(Row(children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        AutoSizeText(
          element.descripcion.toString().trim(),
          style: TextStyle(fontSize: 20),
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
