import 'dart:math';

import 'package:ecommerce_app/controllers/MyCartsController.dart';
import 'package:ecommerce_app/controllers/MyOrdersController.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/models/VoucherModel.dart';
import 'package:ecommerce_app/pages/Orders/OrderDetailsPage.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController {
  var shoppingCart = Rx<ShoppingCartModel?>(null);
  var voucherList = <VoucherModel>[].obs;

  final int shoppingCartId;
  var isLoading = true.obs;
  var address = ''.obs;
  var note = ''.obs;
  var paymentId = 1.obs;
  var discountPrice = 0.0.obs;
  var voucherId = 1;

  CheckOutController(this.shoppingCartId);

  @override
  void onInit() {
    super.onInit();
    fetchShoppingCart();
  }

  void setPaymentMethod(int id) {
    paymentId.value = id;
  }

  void caculateDiscountPrice(VoucherModel? voucher) {
    if (voucher != null) {
      double caculateDiscount = shoppingCart.value!.getTotalPrice() -
          MyCaculator.calculateDiscountedPrice(
              shoppingCart.value!.getTotalPrice(),
              voucher.phanTramGiam.toDouble());
      discountPrice.value = min(caculateDiscount, (voucher.giamToiDa ?? 0.0));
      voucherId = voucher.voucherId;
    } else {
      discountPrice.value = 0.0;
      voucherId = 1;
    }
  }

  Future<void> checkOut() async {
    try {
      final orderId = await ShoppingCartService(Request(http.Client()))
          .checkOut(voucherId, paymentId.value, address.value, note.value,
              shoppingCartId);
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
      final fetchedShoppingCart =
          await ShoppingCartService(Request(http.Client()))
              .fetchShoppingCartById(shoppingCartId);
      final fetchedVouchers = await ShoppingCartService(Request(http.Client()))
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
