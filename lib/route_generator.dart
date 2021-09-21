import 'package:DocumentManager/splash_screen.dart';
import 'package:flutter/material.dart';

import 'LoginWindow.dart';
import 'OpenProjectWindow.dart';
import 'ProjectsWindow.dart';
import 'RegisterWindow.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
        if(args != null && args is String) {
          return MaterialPageRoute(builder: (_) => LoginWindow(data:args));
        }
        return MaterialPageRoute(builder: (_) => LoginWindow(data:"unknown"));
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterWindow());
      case '/splash':
        return MaterialPageRoute(builder: (_) =>SplashScreen());
      case '/projects':
        if(args != null && args is String) {
          return MaterialPageRoute(builder: (_) => ProjectsScreen(data:args));
        }
        return MaterialPageRoute(builder: (_) => LoginWindow(data:"unknown"));
      case '/OpenProject':
        return MaterialPageRoute(builder: (_) => OpenProjectWindow());
      default:
        return MaterialPageRoute(builder: (_) => LoginWindow(data:"unknown"));
    }
  }
}
