import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
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
      final fetchOrder = await OrderService(CustomHttpClient(http.Client()))
          .fetchOrderById(orderId);
      order.value = fetchOrder;
    } catch (e) {
      print("Lỗi ${e}");
    } finally {
      isLoading.value = false;
    }
  }
}
