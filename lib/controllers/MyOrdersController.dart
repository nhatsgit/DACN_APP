import 'package:get/get.dart';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/models/PageListModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:http/http.dart' as http;

class MyOrdersController extends GetxController {
  final ordersByPage = Rx<PageListModel<OrderModel>?>(null);
  final isLoading = true.obs;
  final orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    try {
      isLoading.value = true;
      final result =
          await OrderService(CustomHttpClient(http.Client(), Get.context!))
              .fetchMyOrders();

      orders.value = result.items;
    } catch (e) {
      print('Error fetching orders: $e');
      ordersByPage.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
