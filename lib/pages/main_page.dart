import 'package:ecommerce_app/controllers/MainPageController.dart';
import 'package:ecommerce_app/pages/Account/account.dart';
import 'package:ecommerce_app/pages/ShoppingCarts/MyCartsPage.dart';
import 'package:ecommerce_app/pages/Home/HomePage.dart';
import 'package:ecommerce_app/pages/Orders/MyOrdersPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  final MainPageController controller = Get.put(MainPageController());

  final List<Widget> _pages = [
    HomePage(),
    MyOrdersPage(),
    MyCartsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.selectedIndex.value,
              children: _pages,
            )),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration_sharp),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          onTap: controller.updateIndex,
        );
      }),
    );
  }
}
