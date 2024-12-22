import 'package:ecommerce_app/models/PageListOrderModel.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:http/http.dart' as http;

class MyOrdersController extends GetxController {
  final isLoading = true.obs;
  final orderByPage = Rxn<PageListOrderModel>();

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders(1);
  }

  Future<void> fetchMyOrders(int pageNumber) async {
    try {
      isLoading.value = true;
      final result =
          await OrderService(Request(http.Client())).fetchMyOrders(pageNumber);

      orderByPage.value = result;
    } catch (e) {
      Get.snackbar("Error", "Vui lòng đăng nhập");
    } finally {
      isLoading.value = false;
    }
  }
}
