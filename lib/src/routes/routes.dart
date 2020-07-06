import 'package:flutter/material.dart';

import 'package:snowin/src/pages/benefits/benefits.dart';
import 'package:snowin/src/pages/home/home.dart';
import 'package:snowin/src/pages/sos/sos.dart';

import 'package:snowin/src/pages/wellcome/wellcome_carousel.dart';
import 'package:snowin/src/pages/wellcome/conditions.dart';
import 'package:snowin/src/pages/wellcome/location.dart';
import 'package:snowin/src/pages/wellcome/profile_type.dart';
import 'package:snowin/src/pages/wellcome/level.dart';
import 'package:snowin/src/pages/wellcome/get_started.dart';

import 'package:snowin/src/pages/reports/reports.dart';
import 'package:snowin/src/pages/reports/pistes_map.dart';

import 'package:snowin/src/pages/community/community.dart';



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
  switch (settings.name) {
    case '/wellcome':
      return new MyCustomRoute(
        builder: (_) => new WellcomeCarousel(),
        settings: settings,
      );

    case '/wellcome-conditions':
      return new MyCustomRoute(
        builder: (_) => new Conditions(),
        settings: settings,
      );

    case '/wellcome-location':
      return new MyCustomRoute(
        builder: (_) => new Location(),
        settings: settings,
      );

    case '/wellcome-profile-type':
      return new MyCustomRoute(
        builder: (_) => new ProfileType(),
        settings: settings,
      );

    case '/wellcome-level':
      return new MyCustomRoute(
        builder: (_) => new Level(),
        settings: settings,
      );

    case '/wellcome-get-started':
      return new MyCustomRoute(
        builder: (_) => new GetStarted(),
        settings: settings,
      );

    case '/reports':
      return new MyCustomRoute(
        builder: (_) => new Reports(),
        settings: settings,
      );

    case '/pistes-map':
      return new MyCustomRoute(
        builder: (_) => new PistesMap(),
        settings: settings,
      );

    case '/community':
      return new MyCustomRoute(
        builder: (_) => new Community(),
        settings: settings,
      );

    case '/home':
      return new MyCustomRoute(
        builder: (_) => new Home(),
        settings: settings,
      );

    default:
      return new MyCustomRoute(
        builder: (_) => new WellcomeCarousel(),
        settings: settings,
      );
  }
}
