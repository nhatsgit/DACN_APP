import 'package:ecommerce_app/pages/Auth/login.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../pages/ShoppingCarts/MyCartsPage.dart';
import '../pages/Orders/MyOrdersPage.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String order = '/order';
  static const String cart = '/mycart';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => LoginPage(),
      home: (context) => MainPage(),
      order: (context) => MyOrdersPage(),
      cart: (context) => MyCartsPage(),
    };
  }
}
