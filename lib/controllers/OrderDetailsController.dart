import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderDetailsController extends GetxController {
  var order = Rx<OrderModel?>(null);
  final int orderId;
  var isLoading = true.obs;

  OrderDetailsController(this.orderId);

  @override
  void onInit() {
    super.onInit();
    _fetchOrderById();
  }

  Future<void> _fetchOrderById() async {
    try {
      isLoading.value = true;
      final fetchOrder = await OrderService(HttpRequest(http.Client()))
          .fetchOrderById(orderId);
      order.value = fetchOrder;
    } catch (e) {
      print("Lỗi ${e}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder() async {
    try {
      final message = await OrderService(HttpRequest(http.Client()))
          .cancelOrderById(orderId);
      Get.snackbar(
        "Hủy đơn hàng",
        "Đơn hàng của bạn đã được hủy.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _fetchOrderById();
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
