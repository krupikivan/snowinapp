import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/blocs/app_instance.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/marker_provider.dart';
import 'package:snowin/src/pages/splashscreen_page.dart';
import 'package:snowin/src/routes/routes.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:snowin/src/providers/push_notifications_provider.dart';
import 'package:snowin/src/providers/firebase_analytics_provider.dart';
import 'package:snowin/theme/my_theme.dart';
import 'package:snowin/theme/style.dart';

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
    return AppInstance(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.init()),
        ChangeNotifierProvider(
            create: (context) => CommunityTabsProvider.init()),
        ChangeNotifierProvider(create: (context) => MarkerProvider.init()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Snowin',
        onGenerateRoute: (RouteSettings settings) => getRoute(settings),
        //TODO: Cambie la ruta inicial para poder trabajar en ella
        initialRoute: '/home',
        // home: SplashScreen(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: themeData(),
        supportedLocales: [
          const Locale('en', 'US'), //English
          const Locale('es', 'ES'),
        ],
        navigatorObservers: <NavigatorObserver>[
          firebaseAnalyticsProvider.getAnalyticsObserver()
        ],
      ),
    ));
  }
}
