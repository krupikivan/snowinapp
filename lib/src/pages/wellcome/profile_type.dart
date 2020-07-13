import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/providers/user_repository.dart';

class ProfileType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    final user = Provider.of<UserRepository>(context, listen: false);
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.53,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTcio_1z_94JA-CqwYu8IDb-Dv1936xqgLP9x9gOqhjKXg1UMUk&usqp=CAU"),
                      ),
                    ),
                    Container(
                      height: size.height * 0.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: size.height * 0.045),
                            alignment: Alignment.center,
                            child: Image(
                              height: size.height * 0.18,
                              image:
                                  AssetImage("assets/images/logo-snowin.png"),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.05),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white,
                              ),
                              child: Text(
                                "Foto de Diegoadmin.",
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
                SizedBox(
                  height: size.height * 0.015,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Selecciona tu perfil",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "(podrás modificarlo más tarde)",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    FittedBox(
                      child: Consumer<UserRepository>(
                        builder: (context, user, _) => user.profileTypeList ==
                                null
                            ? CircularProgressIndicator()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (var item in user.profileTypeList)
                                    _radioButtion(item)
                                ],
                              ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    Container(
                      width: size.width * 0.87,
                      height: 48,
                      child: RaisedButton(
                        color: primaryColor,
                        onPressed: () {
                          user
                              .saveProfileTypes()
                              .then((value) => Navigator.pushNamed(
                                  context, '/wellcome-level'))
                              .catchError((error) => Navigator.pop(context));
                        },
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
                      height: size.height * 0.012,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _radioButtion(String value) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Consumer<UserRepository>(
            builder: (context, user, _) => Radio(
              value: value,
              groupValue: user.profileValue,
              onChanged: (val) => user.profileValue = value,
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
