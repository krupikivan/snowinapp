import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:snowin/src/share/preference.dart';

import 'package:snowin/src/providers/register_provider.dart';

class ProfileType extends StatefulWidget {

  @override
  _ProfileTypeState createState() => _ProfileTypeState();
}

class _ProfileTypeState extends State<ProfileType> {
  static final Preferences preferences = Preferences();

  String radioValue = '';
  List<String> _profileType = new List<String>();


  @override
  void initState() {
    super.initState();

    loadProfileTypes();

    preferences.profileType = radioValue.toString();

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
                          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTcio_1z_94JA-CqwYu8IDb-Dv1936xqgLP9x9gOqhjKXg1UMUk&usqp=CAU"),
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
                                child: Text("Foto de Diegoadmin.", style: TextStyle(fontSize: 19),),
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
                      "Selecciona tu perfil",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "(podrás modificarlo más tarde)",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height*0.020,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildProfileTypesTiles(),
                          ),
                        ],
                      )
                    ),
                    SizedBox(height: size.height*0.020,),
                    Container(
                      width: size.width*0.87,
                      height: 48,
                      child: RaisedButton(
                        color: primaryColor,
                        onPressed: (){
                            if(radioValue.isNotEmpty) {
                              saveProfileTypes();
                              //Navigator.pushNamed(context, '/wellcome-level');
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
                    SizedBox(height: size.height*0.012,),
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
                preferences.profileType = val.toString();
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

  List<Widget> buildProfileTypesTiles() {
    List<Widget> elements = new List<Widget>();

    if (_profileType.length > 0) {
        _profileType.forEach((element) {
          elements.add(_radioButtion(element, element));
        });
    } else {
        radioValue = '';
        elements.add( Text('Cargando ...', style: TextStyle(color: Colors.blue),));
    }

    return elements;
  }



  Future<void> loadProfileTypes() async {
      await RegisterProvider().perfiles().then((response) { print(response);
          if(response['ok']) {
              response['data'].forEach((element) {
                _profileType.add(element);
              });
              setState(() {});
          } else {
              throw new Exception('No se pudo cargar los Tipos de perfil');
          }
      }).catchError((error) {
          print(error.toString());
          Navigator.pop(context);
      });
  }

  Future<void> saveProfileTypes() async {
      await RegisterProvider().perfil(radioValue).then((response) { print(response);
          if(response['ok']) {
              Navigator.pushNamed(context, '/wellcome-level');
          } else {
              throw new Exception(response['errores'][0]['message']);
          }
      }).catchError((error) {
          print(error.toString());
          Navigator.pop(context);
      });
  }
}