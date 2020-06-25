import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/providers/register_provider.dart';



class Level extends StatefulWidget {
  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  static final Preferences preferences = Preferences();

  String radioValue = '';
  List<String> _levels = new List<String>();



  @override
  void initState() {
    super.initState();

    loadLevels();

    preferences.profileLevel = radioValue.toString();

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              //color: Colors.amber
            ),
            child: ListView(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height*0.53,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSTSftEmC2SSZt9XSIPQvuAtli2YEi-OGqrqilZwY_DdJGkqua0&usqp=CAU"),
                        ),
                      ),
                      Container(
                        height: size.height*0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top:size.height*0.045),
                              alignment: Alignment.center,
                              child: Image(
                                height: size.height*0.18,
                                image: AssetImage("assets/images/logo-snowin.png"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom:size.height*0.05),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.white,
                                ),
                                child: Text("Foto de Foto de CarlitosRobles.", style: TextStyle(fontSize: 19),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.015,),
                Column(
                  children: [
                    Text(
                      "Selecciona tu nivel para que podamos ofrecerte una experiencia acorde a vos", 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height*0.02,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildLevelTiles(),
                          ),
                        ],
                      )
                    ),
                    SizedBox(height: size.height*0.02,),
                    Container(
                      width: size.width*0.87,
                      height: 48,
                      child: RaisedButton(
                        color: primaryColor,
                        onPressed: (){
                          if(radioValue.isNotEmpty) {
                              saveLevel();
                              //Navigator.pushNamed(context, '/wellcome-get-started');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 10,),
                            SizedBox(width: 10,),
                            Text("Confirmar", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                            SizedBox(width: 10,),
                            FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.015,),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _radioButtion(String value, String text){
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: value,
            groupValue: radioValue,
            onChanged: (val){
              setState(() {
                radioValue = val;
                preferences.profileLevel = val.toString();
              });
            },
          ),
          Text(
           text, style: TextStyle(fontSize: 17, color: Color.fromRGBO(140, 140, 139, 1))
          ),
        ],
      ),
    );
  }

  List<Widget> buildLevelTiles() {
    List<Widget> elements = new List<Widget>();

    if (_levels.length > 0) {
        _levels.forEach((element) {
          elements.add(_radioButtion(element, element));
        });
    } else {
        radioValue = '';
        elements.add(Text('Cargando ...', style: TextStyle(color: Colors.blue),));
    }

    return elements;
  }

  Future<void> loadLevels() async {
      await RegisterProvider().niveles().then((response) { print(response);
          if(response['ok']) {
              response['data'].forEach((element) {
                _levels.add(element);
              });
              setState(() {});
          } else {
              throw new Exception('No se pudo cargar los Niveles');
          }
      }).catchError((error) {
          print(error.toString());
          Navigator.pop(context);
      });
  }

  Future<void> saveLevel() async {
      await RegisterProvider().nivel(radioValue).then((response) { print(response);
          if(response['ok']) {
              Navigator.pushNamed(context, '/wellcome-get-started');
          } else {
              throw new Exception(response['errores'][0]['message']);
          }
      }).catchError((error) {
          print(error.toString());
          Navigator.pop(context);
      });
  }

}