import 'package:flutter/material.dart';
import 'package:snowin/src/blocs/app_instance.dart';
import 'package:snowin/src/pages/splashscreen_page.dart';
import 'package:snowin/src/routes/routes.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snowin/src/providers/firebase_analytics_provider.dart';
import 'package:snowin/src/utils/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final firebaseAnalyticsProvider = FirebaseAnalyticsProvider();

  @override
  void initState() {
    super.initState();
    // final pushProvider = new PushNotificationsProvider();
    // pushProvider.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snowin',
      onGenerateRoute: (RouteSettings settings) => getRoute(settings),
      home: SplashScreen(),
      locale: Locale('es', 'ES'),
      supportedLocales: [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      navigatorObservers: <NavigatorObserver>[
        firebaseAnalyticsProvider.getAnalyticsObserver()
      ],
      theme: ThemeData(
          primaryColor: Color.fromRGBO(29, 113, 184, 1),
          canvasColor: Colors.white),
    );
  }
}
