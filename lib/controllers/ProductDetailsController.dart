import 'package:ecommerce_app/controllers/MainPageController.dart';
import 'package:ecommerce_app/controllers/MyCartsController.dart';
import 'package:ecommerce_app/models/ProductImageModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/ReviewsModel.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductDetailsController extends GetxController {
  var product = Rx<ProductModel?>(null);
  var imageList = <ProductImageModel>[].obs;
  var reviewsList = <ReviewsModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var quantity = 1.obs;
  final int productId;

  ProductDetailsController(this.productId);

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  void updateQuantity(int q) {
    if (q > 0) {
      quantity.value = q;
    }
  }

  Future<void> addToCart() async {
    try {
      final message = await ShoppingCartService(Request(http.Client()))
          .addToCart(productId, quantity.value);

      Get.snackbar(
        "Thành công",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.delete<MyCartsController>();
      Get.to(() => MainPage());
      final mainPageController = Get.find<MainPageController>();
      mainPageController.updateIndex(2);
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

  Future<void> fetchProductDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetchedProduct = await ProductService(Request(http.Client()))
          .fetchProductById(productId);
      final fetchImages = await ProductService(Request(http.Client()))
          .fetchImagesProductById(productId);
      final fetchReviews = await ProductService(Request(http.Client()))
          .fetchReviewsProductById(productId);
      imageList.value = fetchImages;
      product.value = fetchedProduct;
      reviewsList.value = fetchReviews;
    } catch (e) {
      errorMessage.value = 'Lỗi khi lấy sản phẩm: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
