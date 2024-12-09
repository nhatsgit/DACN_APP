import 'package:ecommerce_app/pages/Auth/login.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => LoginPage(),
      home: (context) => MainPage(),
    };
  }
}
