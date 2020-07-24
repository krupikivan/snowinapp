import 'dart:io';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/models/item_kv.dart';
import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_mood_dropdown.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import 'package:snowin/src/widgets/custom_button.dart';
import 'package:snowin/src/widgets/thumbnail.dart';
import 'package:snowin/src/widgets/custom_checkbox.dart';
import 'package:snowin/src/widgets/custom_icon_button.dart';

class NewReport extends StatelessWidget {
  TextEditingController _controllerYouAre;
  List<ItemKV> reportFromtems = [
    ItemKV('0', 'Centro de Ski'),
    ItemKV('1', 'Pista'),
  ];

  TextEditingController _controllerTitle = TextEditingController(text: '');
  TextEditingController _controllerComment = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final report = Provider.of<ReportProvider>(context);
    return Scaffold(
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomMenu(
          item: 1,
        ),
        body: SafeArea(
          child: Container(
              height: size.height,
              child: Stack(
                children: [
                  CustomAppbar(
                    context: context,
                    image:
                        "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    title: "NUEVO REPORTE",
                    height: 70.0,
                    back: true,
                  ),
                  Positioned(
                    top: 70.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: size.height - (70 + 75),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                AutoSizeText(
                                  "IMPORTANTE",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                AutoSizeText(
                                  "Podrás hacer reportes sólo sobre lugares\nque hayas visitado. Te recomendamos ser lo\nmas claro e imparcial posible. Tu reporte\nayuda a otras personas en sus decisiones\ny los puntos que recibes depende de esto",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomTextField(
                                  width: size.width * 0.9,
                                  prefix: "Estas en ",
                                  controller: _controllerYouAre,
                                  readOnly: true,
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Reporte de:",
                                    items: reportFromtems,
                                    value: report.reportFrom,
                                    onChanged: (value) {
                                      print(value);
                                      report.reportFrom = value;
                                    }),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Pista:",
                                    items: report.trackItems,
                                    value: report.track,
                                    onChanged: (value) {
                                      print(value);
                                      report.track = value;
                                    },
                                    error:
                                        report.reportFrom == '1' ? true : false,
                                    replaceFirst: 'Seleccione'),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Calidad nieve:",
                                    items: report.calidadNieveItems,
                                    value: report.calidadNieve,
                                    onChanged: (value) {
                                      print(value);
                                      report.calidadNieve = value;
                                    },
                                    error: true,
                                    replaceFirst: 'Seleccione'),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Clima:",
                                    items: report.climaItems,
                                    value: report.clima,
                                    onChanged: (value) {
                                      print(value);
                                      report.clima = value;
                                    },
                                    error: true,
                                    replaceFirst: 'Seleccione'),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Viento:",
                                    items: report.vientoItems,
                                    value: report.viento,
                                    onChanged: (value) {
                                      print(value);
                                      report.viento = value;
                                    },
                                    error: true,
                                    replaceFirst: 'Seleccione'),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Espera en medios:",
                                    items: report.esperaMediosItems,
                                    value: report.esperaMedios,
                                    onChanged: (value) {
                                      print(value);
                                      report.esperaMedios = value;
                                    },
                                    error: true,
                                    replaceFirst: 'Seleccione'),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomMoodDropdownd(
                                    width: size.width * 0.9,
                                    height: 50,
                                    prefix: "Sensacion general:",
                                    items: report.sensacionGeneralItems,
                                    value: report.sensacionGeneral,
                                    onChanged: (value) {
                                      print(value);
                                      report.sensacionGeneral = value;
                                    },
                                    error: true,
                                    replaceFirst: 'Seleccione'),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomTextField(
                                    width: size.width * 0.9,
                                    prefix: "Titulo: ",
                                    controller: _controllerTitle,
                                    onChanged: (value) {
                                      report.title = value;
                                    },
                                    error: report.title.isEmpty),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Container(
                                  width: size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomIconButton(
                                          icon: Icons.video_call,
                                          iconColor:
                                              Color.fromRGBO(159, 159, 159, 1),
                                          iconSize: 30.0,
                                          width: size.width * 0.25,
                                          borderColor:
                                              Color.fromRGBO(74, 74, 73, 1),
                                          onPressed: () {
                                            getVideo(
                                                ImageSource.camera, report);
                                          }),
                                      CustomIconButton(
                                          icon: Icons.camera_alt,
                                          iconColor:
                                              Color.fromRGBO(159, 159, 159, 1),
                                          iconSize: 30.0,
                                          width: size.width * 0.25,
                                          borderColor:
                                              Color.fromRGBO(74, 74, 73, 1),
                                          onPressed: () {
                                            getImage(
                                                ImageSource.camera, report);
                                          }),
                                      CustomIconButton(
                                          icon: Icons.image,
                                          iconColor:
                                              Color.fromRGBO(159, 159, 159, 1),
                                          iconSize: 30.0,
                                          width: size.width * 0.25,
                                          borderColor:
                                              Color.fromRGBO(74, 74, 73, 1),
                                          onPressed: () {
                                            getImage(
                                                ImageSource.gallery, report);
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Container(
                                  width: size.width * 0.9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        children: _buildImageVideoSection(
                                            report, size),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                CustomTextField(
                                    width: size.width * 0.9,
                                    prefix: "Comentario: ",
                                    maxLength: 700,
                                    maxLines: 5,
                                    controller: _controllerComment,
                                    onChanged: (value) {
                                      report.comment = value;
                                    },
                                    error: report.comment.isEmpty),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Container(
                                  width: size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Compartir: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                          SizedBox(width: 10.0),
                                          CustomCheckbox(
                                              value: report.shareFacebook,
                                              next: Icon(
                                                FontAwesomeIcons.facebookSquare,
                                                color: Colors.blue,
                                              ),
                                              onChanged: (value) {
                                                report.shareFacebook = value;
                                                // setState(() {
                                                // shareFacebook = value;
                                                // });
                                              }),
                                          SizedBox(width: 20.0),
                                          CustomCheckbox(
                                              value: report.shareInstagram,
                                              next: Icon(
                                                FontAwesomeIcons.instagram,
                                                color: Colors.blue,
                                              ),
                                              onChanged: (value) {
                                                report.shareInstagram = value;
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Container(
                                  width: size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButton(
                                        text: "Cancelar",
                                        color: Color.fromRGBO(29, 29, 27, 1),
                                        height: 55,
                                        width: size.width * 0.35,
                                        onPressed: () {
                                          // Navigator.of(context).pop(false);
                                        },
                                      ),
                                      CustomButton(
                                        text: "Guardar",
                                        color: Theme.of(context).primaryColor,
                                        height: 55,
                                        width: size.width * 0.35,
                                        onPressed: () {
                                          if (report.formIsValid())
                                            report.sendReport().then((value) =>
                                                Navigator.of(context)
                                                    .pop(false));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              )),
        ));
  }

  List<Widget> _buildImageVideoSection(ReportProvider report, Size size) {
    List<Widget> elements = new List<Widget>();
    report.medias.forEach((media) {
      if (media.key.toString() == '0') {
        //imagen
        elements.add(new Thumbnail(
          size: size.width * 0.2,
          path: media.value,
          showDeleteButton: true,
          onDelete: () {
            report.removeMediaFromList(media.value.toString());
          },
        ));
      } else if (media.key.toString() == '1') {
        //video
        elements.add(new Thumbnail(
          isVideo: true,
          size: size.width * 0.2,
          path: media.value,
          showDeleteButton: true,
          onDelete: () {
            report.medias.removeWhere((element) =>
                element.value.toString() == media.value.toString());
          },
        ));
      }
    });
    return elements;
  }

  Future getImage(ImageSource source, ReportProvider report) async {
    ImagePicker.pickImage(source: source).then((image) {
      if (image != null) {
        report.addMediaToList(ItemKV(0, image.path));
      }
    }).catchError((error) {
      print(error);
      ImagePicker.retrieveLostData().then((data) {
        if (data != null &&
            data.file != null &&
            data.type == RetrieveType.image) {
          report.addMediaToList(ItemKV(0, data.file.path));
        }
      });
    });
  }

  Future getVideo(ImageSource source, ReportProvider report) async {
    ImagePicker.pickVideo(source: source).then((video) {
      if (video != null) {
        report.addMediaToList(ItemKV(0, video.path));
      }
    }).catchError((error) {
      print(error);
      ImagePicker.retrieveLostData().then((data) {
        if (data != null &&
            data.file != null &&
            data.type == RetrieveType.image) {
          report.addMediaToList(ItemKV(1, data.file.path));
        }
      });
    });
  }
}

// typedef OnSendCallback = void Function();
