import 'package:flutter/material.dart';

import 'package:snowin/src/providers/register_provider.dart';



class Conditions extends StatefulWidget {
  @override
  _ConditionsState createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {

  String _conditions = '';

  @override
  void initState() {
    super.initState();

    loadLegal();

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top:size.height*0.045),
                alignment: Alignment.center,
                child: Image(
                  height: size.height*0.18,
                  image: AssetImage("assets/images/logo-snowin.png"),
                ),
              ),
              SizedBox(height: size.height*0.015,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
                alignment: Alignment.center,
                child: Text(
                  "Términos y condiciones de uso de la plataforma",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color.fromRGBO(124, 123, 123, 1)),
                  textAlign: TextAlign.center
                )
              ),
              SizedBox(height: size.height*0.015,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                height: size.height*0.48,
                child: Scrollbar(
                  child: ListView(
                    children: [
                      Text(
                        _conditions,
                        style: TextStyle(fontSize: 18, color: Color.fromRGBO(140, 140, 139, 1)),
                        textAlign: TextAlign.justify
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height*0.015,),
              Container(
                height: size.height*0.1,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 48,
                      width: size.width*0.4,
                      child: RaisedButton(
                        color: Color.fromRGBO(157, 157, 156, 1),
                        onPressed: (){
                          //Navigator.pushNamed(context, 'wellcome-location');
                          Navigator.pop(context);
                        },
                        child: Text("Rechazar", style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Container(
                      height: 48,
                      width: size.width*0.4,
                      child: RaisedButton(
                        color: primaryColor,
                        onPressed: (){
                          Navigator.pushNamed(context, '/wellcome-location');
                        },
                        child: Text("Aceptar", style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Future<void> loadLegal() async {
      await RegisterProvider().legal().then((response) { print(response);
          if(response['ok']) {
              if(mounted) setState(() {
                  _conditions = response['data'];
              });
          } else {
              throw new Exception('No se pudo cargar los términos y condiciones');
          }
      }).catchError((error) {
          print(error.toString());
          Navigator.pop(context);
      });
  }
}