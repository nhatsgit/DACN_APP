import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController {
  var shoppingCart = Rx<ShoppingCartModel?>(null);
  final int shoppingCartId;
  var isLoading = true.obs;
  var address = ''.obs;
  var note = ''.obs;
  var paymentMethod = 'online'.obs;

  void setPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  CheckOutController(this.shoppingCartId);

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  Future<void> checkOut() async {
    try {
      final message = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .checkOut(1, 1, address.value, note.value, shoppingCartId);
      print("ddat hang thanh cong: ${message}");
    } catch (e) {
      print("Lỗi checkout ${e}");
    }
  }

  Future<void> fetchProductDetails() async {
    try {
      isLoading.value = true;
      final fetchedShoppingCart = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .fetchShoppingCartById(shoppingCartId);

      shoppingCart.value = fetchedShoppingCart;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
