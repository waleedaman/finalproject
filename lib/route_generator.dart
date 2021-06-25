import 'package:finalproject/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/RegisterWindow.dart';
import 'package:finalproject/LoginWindow.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginWindow());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterWindow());
      case '/splash':
        return MaterialPageRoute(builder: (_) =>SplashScreen());
    }
  }
}
