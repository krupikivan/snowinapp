import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/providers/login_provider.dart';
import 'package:snowin/src/providers/welcome_provider.dart';

class Level extends StatelessWidget {
//   @override
//   _LevelState createState() => _LevelState();
// }

// class _LevelState extends State<Level> {

//   @override
//   void initState() {
//     super.initState();
//     preferences.profileLevel = radioValue.toString();

//   }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    final user = Provider.of<LoginProvider>(context, listen: false);
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
                  Consumer<WelcomeProvider>(
                    builder: (context, model, _) => model == null
                        ? SizedBox()
                        : Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: size.height * 0.53,
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        model.listSlider[5].image)),
                              ),
                              Container(
                                height: size.height * 0.55,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.045),
                                      alignment: Alignment.center,
                                      child: Image(
                                        height: size.height * 0.18,
                                        image: AssetImage(
                                            "assets/images/logo-snowin.png"),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: size.height * 0.05),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          "Foto de ${model.listSlider[5].author}.",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Column(
                    children: [
                      Text(
                        "Selecciona tu nivel para que podamos ofrecerte una experiencia acorde a vos",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      FittedBox(
                        child: Consumer<LoginProvider>(
                          builder: (context, user, _) => user.levelTypeList ==
                                  null
                              ? CircularProgressIndicator()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for (var item in user.levelTypeList)
                                      _radioButtion(item)
                                  ],
                                ),
                        ),
                      ),
                      // Container(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: buildLevelTiles(),
                      //       ),
                      //     ],
                      //   )
                      // ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        width: size.width * 0.87,
                        height: 48,
                        child: RaisedButton(
                          color: primaryColor,
                          onPressed: () => user
                              .saveLevel()
                              .then((value) => Navigator.pushNamed(
                                  context, '/wellcome-get-started'))
                              .catchError((error) => Navigator.pop(context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Confirmar",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FaIcon(FontAwesomeIcons.arrowRight,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _radioButtion(String value) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<LoginProvider>(
            builder: (context, user, _) => Radio(
              value: value,
              groupValue: user.levelValue,
              onChanged: (val) => user.levelValue = value,
            ),
          ),
          Text(value,
              style: TextStyle(
                  fontSize: 17, color: Color.fromRGBO(140, 140, 139, 1))),
        ],
      ),
    );
  }
}
