import 'package:ecommerce_app/pages/Account/AccountPage.dart';
import 'package:ecommerce_app/pages/Home/HomePage.dart';
import 'package:ecommerce_app/pages/Orders/MyOrdersPage.dart';
import 'package:ecommerce_app/pages/ShoppingCarts/MyCartsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  var selectedIndex = 0.obs;
  final List<Widget?> pages = [HomePage(), null, null, null];

  void updateIndex(int index) {
    selectedIndex.value = index;
    if (pages[index] == null) {
      pages[index] = getPage(index);
    }
  }

  Widget getPage(int index) {
    switch (index) {
      case 1:
        return MyOrdersPage();
      case 2:
        return MyCartsPage();
      case 3:
        return AccountPage();
      default:
        return HomePage();
    }
  }
}
