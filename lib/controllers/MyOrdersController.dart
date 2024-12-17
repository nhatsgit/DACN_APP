import 'package:get/get.dart';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:http/http.dart' as http;

class MyOrdersController extends GetxController {
  final isLoading = true.obs;
  final orderByPage = Rxn<OrderResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders(1);
  }

  Future<void> fetchMyOrders(int pageNumber) async {
    try {
      isLoading.value = true;
      final result =
          await OrderService(CustomHttpClient(http.Client(), Get.context!))
              .fetchMyOrders(pageNumber);

      orderByPage.value = result;
    } catch (e) {
      print('Error fetching orders: $e');
      Get.snackbar("Error", "Failed to load orders: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
