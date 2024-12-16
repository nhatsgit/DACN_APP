import 'dart:io';

import 'package:ecommerce_app/pages/Auth/login.dart';
import 'package:ecommerce_app/pages/Home/home.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Đường dẫn mặc định
      getPages: [
        GetPage(name: '/', page: () => MainPage()), // Định nghĩa các route
        GetPage(name: '/login', page: () => LoginPage()),
      ],
    );
  }
}
