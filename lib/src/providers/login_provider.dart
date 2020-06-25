import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/utils/exceptions.dart';

import 'package:snowin/src/providers/connectivity_provider.dart';



class LoginProvider {
  

  static LoginProvider _instance = new LoginProvider._internal();
  LoginProvider._internal();
  factory LoginProvider() => _instance;





  //fbLogin
  Future<Map> fbLogin(String token) async {
    print('call end point: fb-login');
    print(token);

    //configurar servicio
    String service = Config.apiUsersAuthUrl + "fb-login";
    service += '?token='+token;

    //Respuesta
    http.Response response;

    try {
      response = await http.get(Uri.encodeFull(service),
                                 headers:{"Accept" : "application/json"});
    } catch(error) {
        print(error.toString());
        throw ServicesException('No se ha podido establecer conexión con el servicio de login con Facebook');
    }

    //analizar la respuesta
    Map data = this.handleResponse(response);

    return data;
  }






  //FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;

  //FirebaseUser myUser;

  // Future<FirebaseUser> _loginWithFacebook() async {
  //   var facebookLogin = new FacebookLogin();
  //   var result = await facebookLogin.logInWithReadPermissions(['email']);

  //   debugPrint(result.status.toString());

  //   if (result.status == FacebookLoginStatus.loggedIn) {
  //     FirebaseUser user =
  //         await _auth.signInWithFacebook(accessToken: result.accessToken.token);
  //     return user;
  //   }
  //   return null;
  // }

  // void _logOut() async {
  //   await _auth.signOut().then((response) {
  //     isLogged = false;
  //   });
  // }

  // void _logIn() {
  //   _loginWithFacebook().then((response) {
  //     if (response != null) {
  //       myUser = response;
  //       isLogged = true;
  //     }
  //   });
  // }


  dynamic handleResponse(http.Response response) {
    print(response.statusCode);
    print(response.body);

    //revisar codigos de estado
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw StatusCodeException(
          "Ocurrió un error al procesar la respuesta del servicio.");
    }

    //decodificar la respuesta
    try {
      return json.decode(response.body);
    } catch (error) {
      print(error.toString());
    }
  }

}