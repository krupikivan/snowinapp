import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/pages/benefits/provider/benefit_provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/marker_provider.dart';
import 'package:snowin/src/pages/drawer/provider/award_provider.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/pages/splashscreen_page.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/providers/login_provider.dart';
import 'package:snowin/src/providers/welcome_provider.dart';
import 'package:snowin/src/routes/routes.dart';
import 'package:snowin/src/share/preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snowin/src/providers/firebase_analytics_provider.dart';
import 'package:snowin/src/providers/connectivity_provider.dart';
import 'package:snowin/src/utils/app_localization.dart';
import 'src/pages/community/notification_tab_pages/provider/notification_provider.dart';
import 'src/pages/community/search_tabs_pages/provider/chat_provider.dart';
import 'src/providers/location_service.dart';
import 'theme/my_theme.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.init()),
        ChangeNotifierProvider(create: (context) => ReportProvider.init()),
        ChangeNotifierProvider(create: (context) => CommunityProvider.init()),
        ChangeNotifierProvider(
            create: (context) => CommunityTabsProvider.init()),
        ChangeNotifierProvider(create: (context) => MarkerProvider.init()),
        ChangeNotifierProvider(create: (context) => BenefitProvider.init()),
        ChangeNotifierProvider(create: (context) => AwardsProvider.init()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => WelcomeProvider.init()),
        ChangeNotifierProvider(create: (context) => ChatProvider.init()),
        ChangeNotifierProvider(
            create: (context) => NotificationProvider.init()),
        // StreamProvider<ConnectionStatus>(
        //     create: (context) => ConnectivityProvider().statusController),
        StreamProvider<ConnectionStatus>(
            create: (context) => ConnectivityProvider().statusController),
        StreamProvider<Position>(
            create: (context) => LocationService().locationStream),
      ],
      child: MaterialApp(
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
        theme: themeData(),
      ),
    );
  }
}
