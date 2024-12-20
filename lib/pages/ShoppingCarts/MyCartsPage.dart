import 'package:ecommerce_app/components/ShoppingCart/ShoppingCart.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/controllers/MyCartsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCartsPage extends StatelessWidget {
  MyCartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyCartsController controller = Get.put(MyCartsController());
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
          ]),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.shoppingCarts.isEmpty) {
                return const Center(child: Text("Giỏ hàng trống."));
              }

              return ListView.builder(
                itemCount: controller.shoppingCarts.length,
                itemBuilder: (context, index) {
                  final cart = controller.shoppingCarts[index];
                  return ShoppingCartWidget(
                    shoppingCart: cart,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
