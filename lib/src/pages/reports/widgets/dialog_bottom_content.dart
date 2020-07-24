import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/utils/app_localization.dart';

class DialogBottomContent extends StatelessWidget {
  const DialogBottomContent({Key key, this.context}) : super(key: key);
  final BuildContext context;
  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;
    final reports = Provider.of<ReportProvider>(context);
    return Container(
      width: size.width * 0.90,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.01),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                reports.hideDialog(2);
                Navigator.pop(context);
                reports.changeWarningDialog(true);
                if (!reports.dialogTopVisible && !reports.dialogBottomVisible) {
                  //TODO: Con esto hay algo raro
                  // Navigator.pop(context)
                }
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.cancel),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.group,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    Column(
                      children: null, //buildFriends(),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        _t(context, "toContact").toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _t(BuildContext context, String label) {
    return AppLocalizations.of(context).translate(label);
  }
}
