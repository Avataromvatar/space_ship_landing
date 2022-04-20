import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_ship_landing/pages/start/start_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => StartPage());
      case '/start':
        return CupertinoPageRoute(
            settings: const RouteSettings(name: '/start'),
            builder: (_) => StartPage());

      default:
        return _errorRoute(settings);
    }
  }

  static Route _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(
              'Something went wrong\nPath:${settings.name ?? ''} undefined'),
        ),
      ),
    );
  }
}
