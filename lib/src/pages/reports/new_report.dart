import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/models/item_kv.dart';
import 'package:snowin/src/widgets/custom_appbar_pages.dart';
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
  TextEditingController _controllerYouAre = TextEditingController(text: '');

  TextEditingController _controllerTitle = TextEditingController(text: '');
  TextEditingController _controllerComment = TextEditingController(text: '');
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final report = Provider.of<ReportProvider>(context);
    _controllerYouAre.text = report.center.name;
    return Scaffold(
        appBar: PreferredSize(
            child: CustomAppbarPages(
              scaffoldDrawer: scaffoldDrawer,
              context: context,
              title: "NUEVO REPORTE",
              back: true,
            ),
            preferredSize: Size(double.infinity, 70)),
        drawerScrimColor: Colors.black54,
        endDrawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomMenu(
          item: 1,
        ),
        body: Container(
            height: size.height - (70 + 75),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                AutoSizeText(
                  "IMPORTANTE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    items: report.reportFrom,
                    value: report.reportFromItem,
                    replaceFirst: 'Seleccione',
                    onChanged: (value) => report.reportFromItem = value),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomDropdownd(
                    width: size.width * 0.9,
                    disabled:
                        report.reportFromItem != report.reportFrom.last.key
                            ? true
                            : false,
                    height: 50,
                    prefix: "Pista:",
                    items: report.trackItems,
                    value: report.track,
                    onChanged: (value) {
                      print(value);
                      report.track = value;
                    },
                    // error: report.reportFromItem.key == '1' ? true : false,
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
                    hint: "Titulo: ",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                          icon: Icons.video_call,
                          iconColor: Color.fromRGBO(159, 159, 159, 1),
                          iconSize: 30.0,
                          width: size.width * 0.25,
                          borderColor: Color.fromRGBO(74, 74, 73, 1),
                          onPressed: () {
                            getVideo(ImageSource.camera, report);
                          }),
                      CustomIconButton(
                          icon: Icons.camera_alt,
                          iconColor: Color.fromRGBO(159, 159, 159, 1),
                          iconSize: 30.0,
                          width: size.width * 0.25,
                          borderColor: Color.fromRGBO(74, 74, 73, 1),
                          onPressed: () {
                            getImage(ImageSource.camera, report);
                          }),
                      CustomIconButton(
                          icon: Icons.image,
                          iconColor: Color.fromRGBO(159, 159, 159, 1),
                          iconSize: 30.0,
                          width: size.width * 0.25,
                          borderColor: Color.fromRGBO(74, 74, 73, 1),
                          onPressed: () {
                            getImage(ImageSource.gallery, report);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: _buildImageVideoSection(report, size),
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
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Text(
                            'Compartir: ',
                            style: TextStyle(color: Colors.black, fontSize: 18),
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
                report.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              text: "Cancelar",
                              color: Color.fromRGBO(29, 29, 27, 1),
                              height: 55,
                              width: size.width * 0.35,
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            CustomButton(
                              text: "Guardar",
                              color: Theme.of(context).primaryColor,
                              height: 55,
                              width: size.width * 0.35,
                              onPressed: () {
                                if (report.formIsValid()) {
                                  report.sendReport().then((value) {
                                    Navigator.of(context).pop(false);
                                    _showPopup(context, 'Reporte enviado');
                                  }).catchError(
                                      (e) => _showPopup(context, e.toString()));
                                } else {
                                  _showPopup(context,
                                      "Complete todos los campos", false);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.1,
                ),
              ],
            )));
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

  _showPopup(context, text, [success = true]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        actions: <Widget>[
          FlatButton(
            child: Text('OK',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 80,
          width: MediaQuery.of(context).size.width / 1.3,
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            leading: Icon(
              success ? Icons.check : Icons.error,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

// typedef OnSendCallback = void Function();
