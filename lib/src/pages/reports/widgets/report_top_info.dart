import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/utils/dialogs.dart';

class ReportTopInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userLocation = Provider.of<Position>(context);
    final user = Provider.of<ReportProvider>(context, listen: false);
    return Container(
      height: 60,
      color: Color.fromRGBO(74, 74, 73, 1),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.terrain,
                size: 22,
                color: Colors.white,
              ),
              SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                      user.center != null ? user.center.name.toString() : '',
                      maxLines: 1,
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  Row(
                    children: [
                      AutoSizeText('Pista: ',
                          maxLines: 1,
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      AutoSizeText(
                          user.pista != null
                              ? user.pista.descripcion.toString()
                              : '',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(255, 224, 0, 1))),
                      Icon(
                        Icons.info,
                        size: 15,
                        color: Color.fromRGBO(255, 224, 0, 1),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            width: 2,
          ),
          GestureDetector(
            onTap: () => goToMapPage(user, context),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 224, 0, 1),
                  borderRadius: BorderRadius.circular(4)),
              child: Icon(Icons.map,
                  size: 23, color: Color.fromRGBO(74, 74, 73, 1)),
            ),
          ),
          Container(
            height: 26,
            width: 1,
            color: Colors.white,
          ),
          Consumer<ReportProvider>(
            builder: (context, report, _) => Row(
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.av_timer,
                    size: 28,
                    color: report.speed
                        ? Color.fromRGBO(255, 224, 0, 1)
                        : Colors.white,
                  ),
                  onPressed: () => report.speed = !report.speed,
                ),
                SizedBox(
                  width: 3,
                ),
                AutoSizeText(
                    report.speed
                        ? '${userLocation.speed.toStringAsFixed(2)} Km/h'
                        : '0.00 Km/h',
                    maxLines: 1,
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            ),
          ),
          Container(
            height: 26,
            width: 1,
            color: Colors.white,
          ),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 31,
                color: Colors.white,
              ),
              SizedBox(
                width: 3,
              ),
              Consumer<ReportProvider>(
                builder: (context, report, _) => report.closestFriends == null
                    ? Text('')
                    : Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: AutoSizeText(
                            user.closestFriends.length.toString(),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void goToMapPage(ReportProvider user, BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/reports'));

    if (user.center != null) {
      if (user.center.id != 0) {
        Navigator.pushNamed(context, '/mapa-pista');
      } else {
        DialogHelper.showSimpleDialog(
            context, 'No está cerca de ningún centro de ski.');
      }
    } else {
      DialogHelper.showSimpleDialog(context, 'Revise su conexion a internet');
    }
  }
}
