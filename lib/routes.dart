import 'package:flutter/material.dart';
import 'package:iconfarm/pages/home.dart';
import 'package:line_icons/line_icons.dart';
import 'package:iconfarm/pages/login.dart';
import 'package:iconfarm/pages/notifications.dart';
import 'package:iconfarm/pages/settings/account.dart';
import 'package:iconfarm/pages/signup.dart';
import 'package:iconfarm/pages/splash.dart';
import 'pages/settings.dart';
import 'pages/settings/help_center.dart';
import 'pages/settings/prefs.dart';

class Router {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    String name = settings.name;
    var args = settings.arguments;

    switch (name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Home());

      case '/login':
        return MaterialPageRoute(builder: (context) => Login());

      case '/signup':
        return MaterialPageRoute(builder: (context) => Signup());

      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfilePage());

      case '/notifications':
        return MaterialPageRoute(builder: (context) => Notifications());

      case '/help_center':
        return MaterialPageRoute(builder: (context) => HelpCenter());

      case '/prefs':
        return MaterialPageRoute(builder: (context) => Preferences());

      case '/account':
        return MaterialPageRoute(builder: (context) => Account());

      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
        return errorRoute();
    }
  }
}

MaterialPageRoute errorRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(LineIcons.bomb, size: 50),
            )
          ],
        ),
      ),
    ),
  );
}
