import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/repository/register_repository.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:snowin/src/utils/exceptions.dart';

class LoginProvider with ChangeNotifier {
  // LoginProvider.init() {
  //   _loadConditions();
  //   _loadProfileTypes();
  //   _loadLevels();
  // }

  var facebookLogin = FacebookLogin();
  static final Preferences _preferences = Preferences();

  bool _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  String _conditions;
  String get conditions => _conditions;
  set conditions(String value) {
    _conditions = value;
    notifyListeners();
  }

  String _profileValue;
  String get profileValue => _profileValue;
  set profileValue(String value) {
    _profileValue = value;
    notifyListeners();
  }

  List<String> _profileTypeList;
  List<String> get profileTypeList => _profileTypeList;
  set profileTypeList(List<String> value) {
    _profileTypeList = value;
    notifyListeners();
  }

  String _levelValue;
  String get levelValue => _levelValue;
  set levelValue(String value) {
    _levelValue = value;
    notifyListeners();
  }

  List<String> _levelTypeList;
  List<String> get levelTypeList => _levelTypeList;
  set levelTypeList(List<String> value) {
    _levelTypeList = value;
    notifyListeners();
  }

  void retrieveInitialData() {
    _loadConditions();
    _loadProfileTypes();
    _loadLevels();
  }

  Future<void> initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        _isLoggedIn = false;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        _isLoggedIn = false;
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');
        var profile = json.decode(graphResponse.body);
        Map response = await fbLogin(facebookLoginResult.accessToken.token);
        if (response['success']) {
          _preferences.email = profile['email'];
          _preferences.nombre = profile['first_name'];
          _preferences.apellidos = profile['last_name'];
          _preferences.userid = response['data']['id'] != null
              ? (response['data']['id']).toString()
              : '';
          _preferences.status = response['data']['status'] != null
              ? (response['data']['status']).toString()
              : '';
          _preferences.token = response['data']['token'] != null
              ? response['data']['token']
              : '';
          _preferences.registerFrom = '1';
        } else {
          throw new Exception(response['message']);
        }
        _preferences.registerFrom = '1';
        print(profile.toString());
        _isLoggedIn = true;
        break;
    }
    notifyListeners();
  }

  Future<void> _loadConditions() async {
    await RegisterRepository().legal().then((response) {
      print(response);
      if (response['ok']) {
        _conditions = response['data'];
        notifyListeners();
      } else {
        throw new Exception('No se pudo cargar los términos y condiciones');
      }
    }).catchError((error) {
      throw 'Error';
    });
  }

  Future<void> _loadProfileTypes() async {
    List<String> _list = [];
    await RegisterRepository().perfiles().then((response) {
      print(response);
      if (response['ok']) {
        response['data'].forEach((element) {
          _list.add(element);
        });
        _profileValue = _list[0];
        _profileTypeList = _list;
        notifyListeners();
      } else {
        throw new Exception('No se pudo cargar los Tipos de perfil');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> saveProfileTypes() async {
    await RegisterRepository().perfil(_profileValue).then((response) {
      _preferences.profileType = _profileValue;
      print(response);
      if (response['ok']) {
        // Navigator.pushNamed(context, '/wellcome-level');
      } else {
        throw new Exception(response['errores'][0]['message']);
      }
    }).catchError((error) {
      print(error.toString());
      // Navigator.pop(context);
    });
  }

  Future<void> _loadLevels() async {
    List<String> _list = [];
    await RegisterRepository().niveles().then((response) {
      print(response);
      if (response['ok']) {
        response['data'].forEach((element) {
          _list.add(element);
        });
        _levelValue = _list[0];
        _levelTypeList = _list;
        notifyListeners();
      } else {
        throw new Exception('No se pudo cargar los Niveles');
      }
    }).catchError((error) {
      print(error.toString());
      throw 'Error';
    });
  }

  Future<void> saveLevel() async {
    await RegisterRepository().nivel(_levelValue).then((response) {
      print(response);
      if (response['ok']) {
      } else {
        throw new Exception(response['errores'][0]['message']);
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  //fbLogin
  Future<Map> fbLogin(String token) async {
    print('call end point: fb-login');
    print(token);

    //configurar servicio
    String service = Config.apiUsersAuthUrl + "fb-login";
    service += '?token=' + token;

    //Respuesta
    http.Response response;

    try {
      response = await http.get(Uri.encodeFull(service),
          headers: {"Accept": "application/json"});
    } catch (error) {
      print(error.toString());
      throw ServicesException(
          'No se ha podido establecer conexión con el servicio de login con Facebook');
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

//facebook login
// Future<void> facebookLogin() async {
//     setState(() { fbLogin = true; });
//     await _facebookSignIn.logIn(['email']).then((fbResponse) {
//               print(fbResponse.status);

//               switch (fbResponse.status) {
//                 case FacebookLoginStatus.loggedIn:
//                   http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${fbResponse.accessToken.token}')
//                           .then((graphResponse) {
//                               var profile = json.decode(graphResponse.body);
//                               print(profile.toString());

//                               LoginProvider().fbLogin(fbResponse.accessToken.token).then((response) {
//                                   if(response['success']) {
//                                       _preferences.email       = profile['email'];
//                                       _preferences.nombre      = profile['first_name'];
//                                       _preferences.apellidos   = profile['last_name'];
//                                       _preferences.userid      = response['data']['id'] != null? (response['data']['id']).toString() : '';
//                                       _preferences.status      = response['data']['status'] != null? (response['data']['status']).toString() : '';
//                                       _preferences.token       = response['data']['token'] != null? response['data']['token'] : '';

//                                       print('go to terms and conditions');
//                                       fbLogin = false;
//                                       _preferences.registerFrom = '1';
//                                       Navigator.pushNamed(context, '/wellcome-conditions');
//                                   } else {
//                                      throw new Exception(response['message']);
//                                   }
//                               });
//                           })
//                           .catchError((error) {
//                               print(error.toString());
//                               fbLogin = false;
//                               throw new Exception(error.toString());
//                           });
//                   break;
//                 case FacebookLoginStatus.cancelledByUser:
//                   throw new Exception('Login cancelled by the user.');
//                   break;
//                 case FacebookLoginStatus.error:
//                   throw new Exception('Facebook gave us: ${fbResponse.errorMessage}');
//                   break;
//               }
//           }).catchError((error) {
//               print(error.toString());
//               fbLogin = false;
//           });
// }

//instagram login
// Future<void> instagramLogin() async {
//     setState(() { instLogin = true; });
//     await instagram.getToken(Config.instagramAppId, Config.instagramAppSecret).then((instResponse) {
//               print(instResponse);

//               if (instResponse != null) {
//               }
//               else {
//               }

//               instLogin = false;
//           }).catchError((error) {
//               print(error.toString());
//               instLogin = false;
//           });
// }
