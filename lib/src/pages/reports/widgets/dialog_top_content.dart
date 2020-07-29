import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/utils/app_localization.dart';

class DialogTopContent extends StatelessWidget {
  const DialogTopContent({Key key, this.context}) : super(key: key);
  final BuildContext context;

  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;
    final reports = Provider.of<ReportProvider>(context);
    return Container(
      width: size.width * 0.90,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.01),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 216, 52, 1),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  child: ClipPolygon(
                    sides: 8,
                    borderRadius: 5.0,
                    rotate: 113.0,
                    child: Container(
                      color: Color.fromRGBO(29, 29, 27, 1),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.exclamation,
                          size: 20,
                          color: Color.fromRGBO(255, 216, 52, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(_t(context, "warning").toUpperCase() + "!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          )),
                      Container(
                          width: size.width * 0.6,
                          child: AutoSizeText(_t(context, "recomendedPistes"),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  decoration: TextDecoration.none))),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    reports.hideDialog(1);
                    Navigator.pop(context);
                    // reports.changeWarningDialog(true);
                    if (!reports.dialogTopVisible &&
                        !reports.dialogBottomVisible) {
                      //TODO: Con esto hay algo raro
                      // Navigator.pop(context);
                    }
                  },
                  child: Container(
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: buildRecomendedTraks(reports, context),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: RaisedButton(
                    color: Color.fromRGBO(80, 79, 79, 1),
                    onPressed: null, // goToMapPage,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.map,
                          color: Color.fromRGBO(255, 216, 52, 1),
                          size: 20,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        AutoSizeText(
                          _t(context, "pistesMap").toUpperCase(),
                          style: TextStyle(
                              color: Color.fromRGBO(255, 216, 52, 1),
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    color: Color.fromRGBO(29, 29, 27, 1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          _t(context, "understood").toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecomendedTraks(
      ReportProvider reports, BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> elements = new List<Widget>();

    elements.add(SizedBox(
      height: 15.0,
    ));
    reports.pistasRecomendadas.forEach((element) {
      elements.add(Container(
          width: size.width * 0.55,
          child: AutoSizeText(
            element.descripcion.toString().trim(),
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                decoration: TextDecoration.none),
            maxLines: 2,
          )));
      elements.add(SizedBox(
        height: 10.0,
      ));
    });

    return elements;
  }

  String _t(BuildContext context, String label) {
    return AppLocalizations.of(context).translate(label);
  }

  // void _hideDialog(int identifier, ReportProvider reports, context) {
  //   reports.changeDialog(identifier);
  //   // (identifier == 1)
  //   //     ? _dialogTopVisible = false
  //   //     : _dialogBottomVisible = false;
  //   Navigator.pop(context);
  //   showWarningsDialog(reports, context);
  //   if (!reports.dialogTopVisible && !reports.dialogBottomVisible) {
  //     Navigator.pop(context);
  //   }
  // }
}
