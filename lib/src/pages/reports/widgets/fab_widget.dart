import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/new_report.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/pages/reports/widgets/filter_dialog.dart';
import 'package:snowin/src/widgets/custom_fab_icon.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key key,
    this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context);
    final size = MediaQuery.of(context).size;
    return Align(
      child: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: report.isLoading
            ? Container(
                width: 50.0,
                height: 50.0,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Center(
                        child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ))),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFabIcon(
                      heroTag: "btn1",
                      isPrimary: false,
                      icon: Icons.filter_list,
                      action: () => showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => FilterDialog(
                              size: size,
                            ),
                          )),
                  SizedBox(
                    width: 10,
                  ),
                  CustomFabIcon(
                    heroTag: "btn2",
                    isPrimary: true,
                    icon: Icons.add,
                    action: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewReport(),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  report.showTopButon
                      ? CustomFabIcon(
                          heroTag: "btn3",
                          isPrimary: true,
                          icon: Icons.expand_less,
                          action: () {
                            scrollController.animateTo(0.0,
                                duration: new Duration(
                                    seconds:
                                        // (report.page < 3 ? report.page : 3)),
                                        (3)),
                                curve: Curves.ease);
                          },
                        )
                      : new SizedBox(width: 0.0, height: 0.0)
                ],
              ),
      ),
      alignment: FractionalOffset.bottomCenter,
    );
  }
}
