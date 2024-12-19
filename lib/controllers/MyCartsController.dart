import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:http/http.dart' as http;

class MyCartsController extends GetxController {
  final shoppingCarts = <ShoppingCartModel>[].obs;
  final isLoading = true.obs;
  final totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShoppingCarts();
  }

  Future<void> fetchShoppingCarts() async {
    try {
      isLoading.value = true;
      final carts = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .fetchMyShoppingCarts();
      shoppingCarts.assignAll(carts);
    } catch (e) {
      print("Error fetching shopping carts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCartItem(int cartItemId) async {
    try {
      final message = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .deleteCartItemById(cartItemId);
      Get.snackbar(
        "${message}",
        "Sản phẩm đã được xóa khỏi giỏ hàng",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      fetchShoppingCarts();
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
