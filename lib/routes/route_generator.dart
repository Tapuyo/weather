
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/splash_page.dart';
import 'package:weather/ui/mobile_home_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => const SplashPage());
      
      case Routes.mobMain:
        return CupertinoPageRoute(builder: (_) => const MobileHomePage());






      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
