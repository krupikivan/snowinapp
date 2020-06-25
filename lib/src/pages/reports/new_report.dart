import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


import '../../widgets/custom_appbar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_button.dart';

class NewReport extends StatefulWidget {
  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
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
                          CustomDropdownd(width: size.width*0.9, height: 50, label: "Estas en:",),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, label: "Reporte de:",),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, label: "Calidad nieve:",),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, label: "Clima:",),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, label: "Viento:",),
                          SizedBox(height: size.height*0.03,),
                          CustomDropdownd(width: size.width*0.9, height: 50, label: "Espera en medios:",),
                          SizedBox(height: size.height*0.03,),
                          Container(
                            width: size.width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _iconItem(size.width*0.25, Icons.video_call),
                                _iconItem(size.width*0.25, Icons.camera_alt),
                                _iconItem(size.width*0.25, Icons.image),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),
                          Container(
                            width: size.width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _imageItem(size.width*0.2, "https://www.urby.in/blog/wp-content/uploads/2017/09/iceskiing-e1506504667758.jpg"),
                                _imageItem(size.width*0.2, "https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Skier-carving-a-turn.jpg/220px-Skier-carving-a-turn.jpg"),
                                _imageItem(size.width*0.2, "https://photo.kidzworld.com/images/2011113/48f7e559-d395-45e4-9951-776c05683824/gallery_a%20gallery.jpg"),
                                _imageItem(size.width*0.2, "https://d96xf8nw30hcy.cloudfront.net/SFImage/Images/places-where-you-can-enjoy-snow-sports-in-india.jpg"),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.03,),
                          Container(
                            width: size.width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(text: "Cancelar", color: Color.fromRGBO(29, 29, 27, 1), height: 55, width: size.width*0.35,),
                                CustomButton(text: "Guardar", color: Theme.of(context).primaryColor, height: 55, width: size.width*0.35,),
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

  Widget _iconItem(double size, IconData icon){
    return Container(
      width: size,
      padding: EdgeInsets.all(7),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: Color.fromRGBO(74, 74, 73, 1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      child: Icon(icon, size: 30, color: Color.fromRGBO(159, 159, 159, 1),),
      );
  }

  Widget _imageItem(double size, String image){
    return Container(
      child: Stack(
        children: [
          Image(
            height: size,
            width: size,
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              child: Icon(Icons.cancel),
            ),
          )
        ],
      ),
    );
  }
}