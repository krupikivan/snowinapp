import 'dart:io';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/models/item_kv.dart';

import 'package:snowin/src/widgets/custom_appbar.dart';
import 'package:snowin/src/widgets/main_menu.dart';
import 'package:snowin/src/widgets/custom_dropdown.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';
import 'package:snowin/src/widgets/custom_button.dart';
import 'package:snowin/src/widgets/thumbnail.dart';
import 'package:snowin/src/widgets/custom_checkbox.dart';
import 'package:snowin/src/widgets/custom_icon_button.dart';



class NewReport extends StatefulWidget {
  final OnSendCallback onSend;
  final String youAre;
  final List<ItemKV> trackItems;
  final List<ItemKV> calidadNieveItems;
  final List<ItemKV> climaItems;
  final List<ItemKV> vientoItems;
  final List<ItemKV> sensacionGeneralItems;
  final List<ItemKV> esperaMediosItems;

  NewReport({ Key key, this.youAre, this.trackItems, this.calidadNieveItems, this.climaItems, this.vientoItems, this.sensacionGeneralItems, this.esperaMediosItems, this.onSend}) : super(key: key);

  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {

  TextEditingController _controllerYouAre;
  String _track = '';
  String _calidadNieve = '';
  String _clima = '';
  String _viento = '';
  String _sensacionGeneral = '';
  String _esperaMedios = '';
  TextEditingController _controllerTitle;
  String _title = '';
  TextEditingController _controllerComment;
  String _comment = '';
  List<ItemKV> _medias;

  bool shareFacebook = false;
  bool shareInstagram = false;



  @override
  void initState() {
    super.initState();

    _controllerYouAre = TextEditingController();
    _controllerYouAre.text = widget.youAre;

    _controllerTitle = TextEditingController();
    _controllerTitle.text = ' ';
    _controllerComment = TextEditingController();
    _controllerComment.text = ' ';

    _medias = List<ItemKV>();

  }

  @override
  void dispose(){

    _controllerYouAre.dispose();
    _controllerTitle.dispose();
    _controllerComment.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: MainMenu(item: 1,),
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              CustomAppbar(
                context: context,
                image: "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                title: "NUEVO REPORTE",
                height: 70.0,
                back: false,
              ),
              Positioned(
                top: 70.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: size.height-(70+75),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: size.height*0.03,),
                          AutoSizeText("IMPORTANTE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.01,),
                          AutoSizeText(
                            "Podrás hacer reportes sólo sobre lugares\nque hayas visitado. Te recomendamos ser lo\nmas claro e imparcial posible. Tu reporte\nayuda a otras personas en sus decisiones\ny los puntos que recibes depende de esto",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: size.height*0.03,),

                          CustomTextField(width: size.width*0.9, prefix: "Estas en ", controller: _controllerYouAre, readOnly: true,),
                          SizedBox(height: size.height*0.03,),
                          CustomTextField(width: size.width*0.9, prefix: "Reporte de: ", controller: _controllerYouAre, readOnly: true),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, prefix: "Pista:", items: widget.trackItems, value: _track, onChanged: (value) {
                              print(value);
                              setState(() { _track = value; });
                          }, error: true),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, prefix: "Calidad nieve:", items: widget.calidadNieveItems, value: _calidadNieve, onChanged: (value) {
                              print(value);
                              setState(() { _calidadNieve = value; });
                          }, error: true),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, prefix: "Clima:", items: widget.climaItems, value: _clima, onChanged: (value) {
                              print(value);
                              setState(() { _clima = value; });
                          }, error: true),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, prefix: "Viento:", items: widget.vientoItems, value: _viento, onChanged: (value) {
                              print(value);
                              setState(() { _viento = value; });
                          }, error: true),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, prefix: "Espera en medios:", items: widget.esperaMediosItems, value: _esperaMedios, onChanged: (value) {
                              print(value);
                              setState(() { _esperaMedios = value; });
                          }, error: true),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, prefix: "Sensacion general:", items: widget.sensacionGeneralItems, value: _sensacionGeneral, onChanged: (value) {
                              print(value);
                              setState(() { _sensacionGeneral = value; });
                          }, error: true),
                          SizedBox(height: size.height*0.03,),
                          CustomTextField(width: size.width*0.9, prefix: "Titulo: ", controller: _controllerTitle, onChanged: (value) {
                              _title = value;
                          }, error: _title.isEmpty),
                          SizedBox(height: size.height*0.03,),

                          SizedBox(height: size.height*0.03,),
                          Container(
                            width: size.width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomIconButton(icon: Icons.video_call, iconColor: Color.fromRGBO(159, 159, 159, 1), iconSize: 30.0, width: size.width*0.25, borderColor: Color.fromRGBO(74, 74, 73, 1), onPressed: () {
                                    getVideo(ImageSource.camera);
                                }),
                                CustomIconButton(icon: Icons.camera_alt, iconColor: Color.fromRGBO(159, 159, 159, 1), iconSize: 30.0, width: size.width*0.25, borderColor: Color.fromRGBO(74, 74, 73, 1), onPressed: () {
                                    getImage(ImageSource.camera);
                                }),
                                CustomIconButton(icon: Icons.image, iconColor: Color.fromRGBO(159, 159, 159, 1), iconSize: 30.0, width: size.width*0.25, borderColor: Color.fromRGBO(74, 74, 73, 1), onPressed: () {
                                    getImage(ImageSource.gallery);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),
                          Container(
                            width: size.width*0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: _buildImageVideoSection(),
                                  )
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),

                          CustomTextField(width: size.width*0.9, prefix: "Comentario: ", maxLength: 700, maxLines: 5, controller: _controllerComment, onChanged: (value) {
                              _comment = value;
                          }, error: _comment.isEmpty),
                          SizedBox(height: size.height*0.03,),

                          Container(
                            width: size.width*0.9,
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                        Text('Compartir: ', style: TextStyle(color: Colors.black, fontSize: 18),),
                                        SizedBox(width: 10.0),
                                        CustomCheckbox(value: shareFacebook, next: Icon(FontAwesomeIcons.facebookSquare, color: Colors.blue,), onChanged: (value) {
                                            setState(() { shareFacebook = value; });
                                        }),
                                        SizedBox(width: 20.0),
                                        CustomCheckbox(value: shareInstagram, next: Icon(FontAwesomeIcons.instagram, color: Colors.blue,), onChanged: (value) {
                                            setState(() { shareInstagram = value; });
                                        }),
                                    ],
                                  )
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),
                          SizedBox(height: size.height*0.03,),

                          Container(
                            width: size.width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(text: "Cancelar", color: Color.fromRGBO(29, 29, 27, 1), height: 55, width: size.width*0.35,
                                    onPressed: () {
                                        Navigator.of(context).pop(false);
                                    },
                                ),
                                CustomButton(text: "Guardar", color: Theme.of(context).primaryColor, height: 55, width: size.width*0.35,
                                    onPressed: () {
                                        if(formIsValid()) sendReport();
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.1,),
                        ],
                      ),
                    ],
                  )
                ),
              ),
            ],
          )
        ),
      )
    );
  }

  List<Widget> _buildImageVideoSection() {
    final size = MediaQuery.of(context).size;
    List<Widget> elements = new List<Widget>();

    _medias.forEach((media) {
        if(media.key.toString() == '0') { //imagen
            elements.add(new Thumbnail(size: size.width*0.2, path: media.value, showDeleteButton: true, onDelete: () {
                _medias.removeWhere((element) => element.value.toString() == media.value.toString());
                setState(() {});
            },));
        } else if(media.key.toString() == '1') { //video
            elements.add(new Thumbnail(isVideo: true, size: size.width*0.2, path: media.value, showDeleteButton: true, onDelete: () {
                _medias.removeWhere((element) => element.value.toString() == media.value.toString());
                setState(() {});
            },));
        }
    });

    return elements;
  }



  Future getImage(ImageSource source) async {
    ImagePicker.pickImage(source: source)
                .then((image) {
                    if(image != null) {
                        _medias.add(ItemKV(0, image.path));
                        setState(() {});
                    }
                })
                .catchError((error) {
                    print(error);
                    ImagePicker.retrieveLostData()
                                .then((data) {
                                    if (data != null && data.file != null && data.type == RetrieveType.image) {
                                        _medias.add(ItemKV(0, data.file.path));
                                        setState(() {});
                                    }
                                });
                });
  }

  Future getVideo(ImageSource source) async {
    ImagePicker.pickVideo(source: source)
                .then((video) {
                    if(video != null) {
                        _medias.add(ItemKV(1, video.path));
                        setState(() {});
                    }
                })
                .catchError((error) {
                    print(error);
                    ImagePicker.retrieveLostData()
                                .then((data) {
                                    if (data != null && data.file != null && data.type == RetrieveType.image) {
                                        _medias.add(ItemKV(1, data.file.path));
                                        setState(() {});
                                    }
                                });
                });
  }

  bool formIsValid() {
      return (/*_track.isNotEmpty*/true && _title.isNotEmpty && _comment.isNotEmpty && _calidadNieve.isNotEmpty &&
              _esperaMedios.isNotEmpty && _viento.isNotEmpty && _clima.isNotEmpty && _sensacionGeneral.isNotEmpty);
  }

  Future<void> sendReport() async {
      List<File> multimedias = List<File>();
      _medias.forEach((media) {
          multimedias.add(File(media.value));
      });

      await SnowinProvider().sendReport(/*_track*/ '1', _title, _comment, _calidadNieve, _esperaMedios,
                                        _viento, _clima, _sensacionGeneral, multimedias)
                            .then((response) { print(response);
                                if(response['ok']) {
                                    widget.onSend();
                                    Navigator.of(context).pop(false);
                                } else {
                                    throw new Exception('Error');
                                }
                            })
                            .catchError((error) {
                                print(error.toString());
                                widget.onSend();
                                Navigator.of(context).pop(false);
                            });
  }

}



typedef OnSendCallback = void Function();