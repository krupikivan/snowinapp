import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/export.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/repository/report_repository.dart';
import 'package:snowin/src/utils/app_localization.dart';
import 'package:snowin/src/utils/message_border.dart';
import 'package:snowin/src/utils/dialogs.dart';
import 'package:snowin/src/models/report.dart';
import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/pages/reports/widgets/time.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/ranking_w.dart';
import 'package:snowin/src/widgets/comment_w.dart';
import 'package:snowin/src/widgets/marquee.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class ReportDetail extends StatelessWidget {
  // Report report;

  // _ReportDetailState(this.report);

  CarouselController buttonCarouselController = CarouselController();
  int _currentIndex = 0;
  IconData iconData;
  double rate;
  // final OnBackCallback onBack;

  // ReportDetail({Key key, this.onBack}) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();

  // switch (report.sensacionGeneral.toString()) {
  //   case 'REGULAR':
  //     iconData = Icons.sentiment_neutral;
  //     break;
  //   case 'MALA':
  //     iconData = Icons.mood_bad;
  //     break;
  //   default:
  //     iconData = Icons.insert_emoticon;
  //     break;
  // }
  // rate = double.parse(report.copos.toString());
  // setState(() {});
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final report = Provider.of<ReportProvider>(context);
    // final user = Provider.of<UserProvider>(context);

    return Scaffold(
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomMenu(
          item: 1,
        ),
        floatingActionButton: _flotingActionButton(context, report),
        body: SafeArea(
          child: Container(
              height: size.height,
              child: Stack(children: [
                CustomAppbar(
                  context: context,
                  image:
                      "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  title: _t(context, "reports").toUpperCase(),
                  height: 70.0,
                  back: true,
                ),
                Positioned(
                    top: 70.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                        height: size.height - (70 + 75),
                        child: ListView(children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 58,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width * 0.45,
                                          child: ListTile(
                                            contentPadding: EdgeInsets.only(
                                                left: size.width * 0.2),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Marquee(
                                                  child:
                                                      Wrap(children: <Widget>[
                                                    Icon(
                                                      Icons.person_pin,
                                                      color: Colors.white,
                                                      size: 22,
                                                    ),
                                                    Text(
                                                        report
                                                                .reportSelected
                                                                .user
                                                                .username ??
                                                            '',
                                                        // .toString()
                                                        // .trim(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromRGBO(
                                                                    159,
                                                                    159,
                                                                    159,
                                                                    1))),
                                                  ]),
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  animationDuration:
                                                      Duration(seconds: 3),
                                                  backDuration: Duration(
                                                      milliseconds: 5000),
                                                  pauseDuration: Duration(
                                                      milliseconds: 2500),
                                                ),
                                                AutoSizeText(
                                                    report.reportSelected.user
                                                        .nivel
                                                        .toString()
                                                        .trim(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(
                                                            159, 159, 159, 1))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 0.45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Time(
                                                      time: report
                                                          .reportSelected.fecha
                                                          .toString()
                                                          .trim())),
                                              _popUpBottomMenu(context)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _carousel(context, report),
                                ],
                              ),
                              Positioned(
                                top: size.width * 0.04,
                                left: size.width * 0.03,
                                child: _avatar(
                                    report.reportSelected.user.image, size),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: report.reportSelected.centro.name
                                              .toString()
                                              .trim() +
                                          ': ',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: report
                                          .reportSelected.pista.descripcion
                                          .toString()
                                          .trim(),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 22),
                                    )
                                  ]),
                                ),
                                AutoSizeText(
                                  report.reportSelected.titulo
                                      .toString()
                                      .trim(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          AutoSizeText(
                                            _t(context, "status").toUpperCase(),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Icon(
                                            iconData,
                                            size: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: _t(context, "snow") + ": ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: report.calidadNieveItems
                                                  .firstWhere((element) =>
                                                      element.key.toString() ==
                                                      report.calidadNieve
                                                          .toString())
                                                  .value
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 17),
                                            ),
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  _t(context, "weather") + ": ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: report.climaItems
                                                  .firstWhere((element) =>
                                                      element.key.toString() ==
                                                      report.clima.toString())
                                                  .value
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 17),
                                            ),
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: _t(context, "wind") + ": ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: report.vientoItems
                                                  .firstWhere((element) =>
                                                      element.key.toString() ==
                                                      report.viento.toString())
                                                  .value
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 17),
                                            ),
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: _t(context, "waitMiddle") +
                                                  ": ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: report.esperaMediosItems
                                                  .firstWhere((element) =>
                                                      element.key.toString() ==
                                                      report.esperaMedios
                                                          .toString())
                                                  .value
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 17),
                                            ),
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  _t(context, "traffic") + ": ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: "Congestionado",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 17),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                AutoSizeText(
                                  report.reportSelected.comentario
                                      .toString()
                                      .trim(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                report.allComments.isEmpty
                                    ? Text('No se encontraron comentarios')
                                    : SizedBox(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                report.allComments.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                ListTile(
                                                  title: Text(report
                                                      .allComments[index]
                                                      .comentario),
                                                )),
                                      )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.15,
                          )
                        ]))),
                report.showReportDetailTutorial
                    ? _tutorial(context, report)
                    : Container(),
              ])),
        ));
  }

  Widget _avatar(String image, Size size) {
    return Container(
      width: 0.17 * size.width,
      height: 0.17 * size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        image: DecorationImage(
            image: image.isNotEmpty
                ? NetworkImage(Config.apiImageBaseUrl + image)
                : Image.asset('assets/images/male.png').image,
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _popUpBottomMenu(BuildContext context) {
    return PopupMenuButton(
      child: Icon(
        Icons.more_vert,
        size: 35,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: "1",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.share,
                  size: 30,
                ),
                Text(
                  _t(context, "shere"),
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          PopupMenuItem(
            value: "1",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.report,
                  size: 30,
                ),
                Text(
                  _t(context, "report"),
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ];
      },
    );
  }

  Widget _carousel(BuildContext context, ReportProvider report) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      child: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  onPageChanged: (value, item) {
                    // setState(() {
                    _currentIndex = value;
                    // });
                  },
                  height: double.infinity,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.1,
                  initialPage: 0,
                ),
                items: _buildCarruselItems(context, report),
              )),
          Positioned(
            top: 5,
            child: Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_call,
                    size: 28,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.camera_alt,
                    size: 24,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          buttonCarouselController.previousPage();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildCarruselButtons(report),
                    ),
                    GestureDetector(
                        onTap: () {
                          buttonCarouselController.nextPage();
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCarruselButtons(ReportProvider report) {
    List<Widget> elements = new List<Widget>();

    int i = 0;
    report.reportSelected.multimedias.forEach((element) {
      elements.add(_carouselButton(i++));
    });

    if (elements.length == 0) elements.add(_carouselButton(0));

    return elements;
  }

  Widget _carouselButton(int page) {
    return GestureDetector(
      onTap: () {
        buttonCarouselController.jumpToPage(page);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 13,
        height: 13,
        decoration: new BoxDecoration(
          color: (_currentIndex == page)
              ? Colors.white
              : Color.fromRGBO(208, 208, 208, 1),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  List<Widget> _buildCarruselItems(
      BuildContext context, ReportProvider report) {
    List<Widget> elements = new List<Widget>();

    report.reportSelected.multimedias.forEach((element) {
      elements.add(_carouselItem(context, element.ruta));
    });

    if (elements.length == 0) elements.add(_carouselItem(context, ''));

    return elements;
  }

  Widget _carouselItem(BuildContext context, String image) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Container(
        width: double.infinity,
        child: Image(
          fit: BoxFit.cover,
          image: image.isNotEmpty
              ? NetworkImage(Config.apiImageBaseUrl + image)
              : Image.asset('assets/images/no_image.png').image,
        ),
      ),
    );
  }

  Widget _flotingActionButton(BuildContext context, ReportProvider report) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.5,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.only(left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showRateDialog(report, context);
                },
                icon: Icon(
                  Icons.ac_unit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  showCommentDialog(report, context);
                },
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tutorial(BuildContext context, ReportProvider reports) {
    final size = MediaQuery.of(context).size;
    return Positioned(
        bottom: 5,
        child: InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
            height: 180,
            width: size.width * 0.95,
            decoration: BoxDecoration(
                color: Color.fromRGBO(74, 74, 73, 0.8),
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Positioned(
                    bottom: 135,
                    child: Container(
                        width: size.width * 0.95,
                        alignment: Alignment.center,
                        child: Text(
                          _t(context, "interactSnowing").toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ))),
                Positioned(
                    bottom: 70,
                    child: Container(
                      width: size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Colors.green,
                              shape: MessageBorder(position: -30),
                            ),
                            child: AutoSizeText(
                              _t(context, "rateReport").toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.08,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Colors.green,
                              shape: MessageBorder(position: 55),
                            ),
                            child: AutoSizeText(
                              _t(context, "commentReport").toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          onTap: () {
            reports.hideTutorial();
          },
        ));
  }

  String _t(BuildContext context, String label) {
    return AppLocalizations.of(context).translate(label);
  }

  void showRateDialog(ReportProvider report, context) {
    print('show rate dialog');
    final size = MediaQuery.of(context).size;
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: size.width * 0.05),
                      child: Column(
                        children: [
                          RankingW(
                            afterRate: (value) {
                              report
                                  .valorar(value)
                                  .then((value) =>
                                      DialogHelper.showSimpleDialog(
                                          context, 'Reporte evaluado'))
                                  .catchError((e) =>
                                      DialogHelper.showErrorDialog(
                                          context, e.toString()));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showCommentDialog(ReportProvider report, context) {
    print('show comment dialog');
    final size = MediaQuery.of(context).size;

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: size.width * 0.05),
                      child: Column(
                        children: [
                          CommentW(
                            afterComment: (value) {
                              report
                                  .comenta(value)
                                  .then((value) =>
                                      DialogHelper.showSimpleDialog(
                                          context, 'Reporte comentado'))
                                  .catchError((onError) =>
                                      DialogHelper.showErrorDialog(
                                          context, 'Error al comentar'));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
// typedef OnBackCallback = void Function();
