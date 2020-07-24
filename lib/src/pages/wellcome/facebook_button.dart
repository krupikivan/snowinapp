import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/providers/login_provider.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key key, this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginProvider>(context, listen: false);
    return Container(
      width: size.width * 0.87,
      height: 48,
      child: RaisedButton(
        color: Color.fromRGBO(59, 89, 152, 1),
        onPressed: () {
          user.initiateFacebookLogin();
          // Navigator.pushNamed(context, '/wellcome-conditions');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FaIcon(FontAwesomeIcons.facebookSquare, color: Colors.white),
            Text(
              "Ingresa con tu cuenta de Facebook",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
