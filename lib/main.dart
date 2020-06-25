import 'package:flutter/material.dart';
import 'package:snowin/src/blocs/provider.dart';
import 'package:snowin/src/pages/splashscreen_page.dart';
import 'package:snowin/src/routes/routes.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:snowin/src/providers/push_notifications_provider.dart';
import 'package:snowin/src/providers/firebase_analytics_provider.dart';

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
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snowin',
      onGenerateRoute: (RouteSettings settings) => getRoute(settings),
      home: SplashScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), //English
        const Locale('es', 'ES'),
      ],
      navigatorObservers: <NavigatorObserver>[
        firebaseAnalyticsProvider.getAnalyticsObserver()
      ],
    ));
  }
}
