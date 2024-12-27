import 'package:ecommerce_app/models/PageListProductModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:http/http.dart' as http;

class ProductsByImageController extends GetxController {
  final productsByPage = Rxn<PageListProductModel>();
  var productsImage = <ProductModel>[].obs;

  var productSlider = <ProductModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  var isLoadingSuggestions = false.obs;
  var isLoadingSlider = false.obs;
  var isLoadingCategories = false.obs;
  final int categoryId;
  final String imagePath;
  ProductsByImageController(
      {required this.categoryId, required this.imagePath});

  @override
  void onInit() {
    super.onInit();
    // fetchFilteredProducts(categoryId: categoryId, pageNumber: 1);
    fetchProducts();
  }

  // Future<void> fetchFilteredProducts(
  //     {String? keyword,
  //     int? categoryId,
  //     double? minPrice,
  //     double? maxPrice,
  //     required int pageNumber}) async {
  //   try {
  //     isLoadingSuggestions(true);

  //     final client = HttpRequest(http.Client());

  //     final products = await ProductService(client).fetchFilteredProducts(
  //         keyword: keyword,
  //         minPrice: minPrice,
  //         maxPrice: maxPrice,
  //         categoryId: categoryId,
  //         pageNumber: pageNumber);
  //     productsByPage.value = products;
  //     print('haha');
  //   } catch (e) {
  //     Get.snackbar("Không tìm thấy", "Không có sản phẩm cần tìm",
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoadingSuggestions(false);
  //   }
  // }
  Future<void> fetchProducts() async {
    try {
      isLoadingSuggestions(true);

      final client = HttpRequest(http.Client());

      final products = await ProductService(client).uploadImage(imagePath);
      productsImage.value = products;
      print("haha");
    } catch (e) {
      Get.snackbar("Không tìm thấy", "Không có sản phẩm cần tìm",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSuggestions(false);
    }
  }
}
