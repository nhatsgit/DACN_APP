import 'package:ecommerce_app/controllers/MyCartsController.dart';
import 'package:ecommerce_app/controllers/MyOrdersController.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/models/VoucherModel.dart';
import 'package:ecommerce_app/pages/Orders/OrderDetailsPage.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController {
  var shoppingCart = Rx<ShoppingCartModel?>(null);
  var voucherList = <VoucherModel>[].obs;

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
    fetchShoppingCart();
  }

  Future<void> checkOut() async {
    try {
      final orderId = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .checkOut(1, 1, address.value, note.value, shoppingCartId);
      Get.delete<MyCartsController>();
      Get.delete<MyOrdersController>();
      Get.offAll(() => MainPage());
      Get.to(() => OrderDetailsPage(orderId: orderId));
    } catch (e) {
      print("Lỗi checkout ${e}");
    }
  }

  Future<void> fetchShoppingCart() async {
    try {
      isLoading.value = true;
      final fetchedShoppingCart = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .fetchShoppingCartById(shoppingCartId);
      final fetchedVouchers = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .fetchVoucherByShopId(fetchedShoppingCart.shopId);
      shoppingCart.value = fetchedShoppingCart;
      voucherList.value = fetchedVouchers;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
