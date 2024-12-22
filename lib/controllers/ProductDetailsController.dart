import 'package:ecommerce_app/controllers/MainPageController.dart';
import 'package:ecommerce_app/controllers/MyCartsController.dart';
import 'package:ecommerce_app/models/ProductImageModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/ReviewsModel.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/services/CategoryServices.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductDetailsController extends GetxController {
  var product = Rx<ProductModel?>(null);
  var imageList = <ProductImageModel>[].obs;
  var reviewsList = <ReviewsModel>[].obs;
  var categoryName = ''.obs;
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
      final message = await ShoppingCartService(HttpRequest(http.Client()))
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
      await Future.wait([
        fetchProduct(),
        fetchProductImages(),
        fetchProductReviews(),
      ]);
    } catch (e) {
      errorMessage.value = 'Lỗi khi lấy sản phẩm: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProduct() async {
    try {
      final fetchedProduct = await ProductService(HttpRequest(http.Client()))
          .fetchProductById(productId);
      product.value = fetchedProduct;

      final fetchedCategory = await CategoryService(HttpRequest(http.Client()))
          .fetchCategoryById(fetchedProduct.productCategoryId);
      categoryName.value = fetchedCategory.tenLoai;
    } catch (e) {
      throw 'Lỗi khi lấy thông tin sản phẩm: $e';
    }
  }

  Future<void> fetchProductImages() async {
    try {
      final fetchImages = await ProductService(HttpRequest(http.Client()))
          .fetchImagesProductById(productId);
      imageList.value = fetchImages;
    } catch (e) {
      throw 'Lỗi khi lấy hình ảnh sản phẩm: $e';
    }
  }

  Future<void> fetchProductReviews() async {
    try {
      final fetchReviews = await ProductService(HttpRequest(http.Client()))
          .fetchReviewsProductById(productId);
      reviewsList.value = fetchReviews;
    } catch (e) {
      throw 'Lỗi khi lấy đánh giá sản phẩm: $e';
    }
  }
}
