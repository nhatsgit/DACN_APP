import 'package:ecommerce_app/models/ProductImageModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/ReviewsModel.dart';
import 'package:ecommerce_app/pages/Carts/MyCartsPage.dart';
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
      final message = await ShoppingCartService(
              CustomHttpClient(http.Client(), Get.context!))
          .AddToCart(productId, quantity.value);

      Get.snackbar(
        "Thành công",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.to(() => MyCartsPage());
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
      final fetchedProduct =
          await ProductService(CustomHttpClient(http.Client(), Get.context!))
              .fetchProductById(productId);
      final fetchImages =
          await ProductService(CustomHttpClient(http.Client(), Get.context!))
              .fetchImagesProductById(productId);
      final fetchReviews =
          await ProductService(CustomHttpClient(http.Client(), Get.context!))
              .fetchReviewsProductById(productId);
      imageList.value = fetchImages;
      product.value = fetchedProduct;
      reviewsList.value = fetchReviews;
    } catch (e) {
      errorMessage.value = 'Lỗi khi lấy sản phẩm: $e';
      print('Lỗi khi lấy sản phẩm: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
