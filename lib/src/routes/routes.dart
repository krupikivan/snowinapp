import 'package:flutter/material.dart';
import 'package:snowin/src/pages/benefits/benefit_detail.dart';
import 'package:snowin/src/pages/benefits/benefits.dart';
import 'package:snowin/src/pages/community/community.dart';
import 'package:snowin/src/pages/community/user_chat.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/export.dart';
import 'package:snowin/src/pages/drawer/export.dart';
import 'package:snowin/src/pages/drawer/profile_page.dart';
import 'package:snowin/src/pages/home/home.dart';
import 'package:snowin/src/pages/sos/sos.dart';
import 'package:snowin/src/pages/wellcome/wellcome_carousel.dart';
import 'package:snowin/src/pages/wellcome/conditions.dart';
import 'package:snowin/src/pages/wellcome/location.dart';
import 'package:snowin/src/pages/wellcome/profile_type.dart';
import 'package:snowin/src/pages/wellcome/level.dart';
import 'package:snowin/src/pages/wellcome/get_started.dart';
import 'package:snowin/src/pages/reports/mapa_pista.dart';
import 'package:snowin/src/pages/reports/reports.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (animation.status == AnimationStatus.reverse)
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

MaterialPageRoute getRoute(RouteSettings settings) {
  print(settings);
  print(settings.name);
  print(settings.arguments);
  switch (settings.name) {
    case '/wellcome':
      return MyCustomRoute(
        builder: (_) => WellcomeCarousel(),
        settings: settings,
      );

    case '/wellcome-conditions':
      return MyCustomRoute(
        builder: (_) => Conditions(),
        settings: settings,
      );

    case '/wellcome-location':
      return MyCustomRoute(
        builder: (_) => Location(),
        settings: settings,
      );

    case '/wellcome-profile-type':
      return MyCustomRoute(
        builder: (_) => ProfileType(),
        settings: settings,
      );

    case '/wellcome-level':
      return MyCustomRoute(
        builder: (_) => Level(),
        settings: settings,
      );

    case '/wellcome-get-started':
      return MyCustomRoute(
        builder: (_) => GetStarted(),
        settings: settings,
      );

    case '/home':
      return MyCustomRoute(
        builder: (_) => Home(),
        settings: settings,
      );

    case '/reports':
      return MyCustomRoute(
        builder: (_) => Reports(),
        settings: settings,
      );

    case '/mapa-pista':
      return MyCustomRoute(
        builder: (_) => MapaPista(),
        settings: settings,
      );

    case '/sos':
      return MyCustomRoute(
        builder: (_) => Sos(),
        settings: settings,
      );
/**
 * *---------------------Navigator managing community pages
 */
    case '/community':
      return MyCustomRoute(
        builder: (_) => Community(),
        settings: settings,
      );

    case '/userProfile':
      return MyCustomRoute(
        builder: (_) => UserProfile(),
        settings: settings,
      );
    case '/userChat':
      return MyCustomRoute(
        builder: (_) => UserChat(
          oldContext: settings.arguments,
        ),
        settings: settings,
      );
/**
 * *---------------------Navigator managing drawer pages
 */
    case '/myBenefits':
      return MyCustomRoute(
        builder: (_) => MyBenefits(),
        settings: settings,
      );

    case '/profile':
      return MyCustomRoute(
        builder: (_) => ProfilePage(),
        settings: settings,
      );

    case '/myAwards':
      return MyCustomRoute(
        builder: (_) => MyAwards(),
        settings: settings,
      );

    case '/ask':
      return MyCustomRoute(
        builder: (_) => Ask(
          oldContext: settings.arguments,
        ),
        settings: settings,
      );

/**
 * *---------------------Navigator managing benefits pages
 */
    case '/benefits':
      return MyCustomRoute(
        builder: (_) => Benefits(),
        settings: settings,
      );

    case '/benefitDetail':
      return MyCustomRoute(
        builder: (_) => BenefitDetail(),
        settings: settings,
      );

    default:
      return MyCustomRoute(
        builder: (_) => WellcomeCarousel(),
        settings: settings,
      );
  }
}
