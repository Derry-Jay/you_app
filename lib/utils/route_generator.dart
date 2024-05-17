import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../models/common/route_argument.dart';
import '../views/screens/about/profile_screen.dart';
import '../views/screens/auth/register_screen.dart';
import '../views/screens/common/empty_screen.dart';
import '../views/screens/auth/login_screen.dart';
import 'enums.dart';

class RouteGenerator {
  late bool? _shouldPerformTransition;

  static final RouteGenerator _singleton = RouteGenerator._internal();

  factory RouteGenerator({bool? flag}) {
    _singleton._shouldPerformTransition = flag;
    return _singleton;
  }

  RouteGenerator._internal();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as RouteArgument?;

    Widget pageBuilder(BuildContext context) {
      switch (settings.name) {
        case '/login':
          return const LoginScreen();
        case '/profile':
          return const ProfileScreen();
        case '/register':
          return const RegisterScreen();
        default:
          return const EmptyScreen();
      }
    }

    Widget screenBuilder(
        BuildContext ct1, Animation<double> a1, Animation<double> a2) {
      Widget contentBuilder(BuildContext ct2, Widget? c3) {
        Widget portionBuilder(BuildContext ct3, Widget? c4) {
          return c4 ?? pageBuilder(ct3);
        }

        return AnimatedBuilder(
            animation: a2, builder: portionBuilder, child: c3);
      }

      return AnimatedBuilder(animation: a1, builder: contentBuilder);
    }

    Widget transitionBuilder(BuildContext ct4, Animation<double> a1,
        Animation<double> a2, Widget c1) {
      Widget transitionedPageBuilder(BuildContext ct5, Widget? c2) {
        Widget transitionedScreenBuilder(BuildContext ct6, Widget? c5) {
          try {
            switch (args?.type) {
              case TransitionType.slide:
                return SlideTransition(
                    position: a1.drive(Tween(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(0.0, 0.0))),
                    child: c5);
              case TransitionType.scale:
                return ScaleTransition(scale: a1, child: c5);
              case TransitionType.size:
                return SizeTransition(sizeFactor: a1, child: c5);
              case TransitionType.rotate:
                return RotationTransition(turns: a2, child: c5);
              case TransitionType.fade:
                return FadeTransition(opacity: a1, child: c5);
              default:
                return pageBuilder(ct6);
            }
          } catch (e) {
            e.jot();
            return pageBuilder(ct6);
          }
        }

        return AnimatedBuilder(
            animation: a2, builder: transitionedScreenBuilder, child: c2);
      }

      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoPageTransition(
              linearTransition: false,
              primaryRouteAnimation: a1,
              secondaryRouteAnimation: a2,
              child: c1);
        default:
          switch (args?.type) {
            case null:
            case TransitionType.normal:
              return screenBuilder(ct4, a1, a2);
            default:
              return AnimatedBuilder(
                  animation: a1, builder: transitionedPageBuilder, child: c1);
          }
      }
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoPageRoute(builder: pageBuilder);
      default:
        return (_shouldPerformTransition ?? false)
            ? PageRouteBuilder(
                settings: settings,
                pageBuilder: screenBuilder,
                transitionsBuilder: transitionBuilder)
            : MaterialPageRoute(builder: pageBuilder, settings: settings);
    }
  }
}
