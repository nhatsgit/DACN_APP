import 'package:get/get.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:http/http.dart' as http;

class ShoppingCartController extends GetxController {
  // Sử dụng List<ShoppingCartModel> thay vì List<ShoppingCart>
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
}
