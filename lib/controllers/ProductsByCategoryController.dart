import 'package:ecommerce_app/models/PageListProductModel.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:http/http.dart' as http;

class ProductsByCategoryController extends GetxController {
  final productsByPage = Rxn<PageListProductModel>();

  var productSlider = <ProductModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  var isLoadingSuggestions = false.obs;
  var isLoadingSlider = false.obs;
  var isLoadingCategories = false.obs;
  final int categoryId;

  ProductsByCategoryController({required this.categoryId});

  @override
  void onInit() {
    super.onInit();
    fetchFilteredProducts(categoryId: categoryId, pageNumber: 1);
  }

  Future<void> fetchFilteredProducts(
      {String? keyword,
      int? categoryId,
      double? minPrice,
      double? maxPrice,
      required int pageNumber}) async {
    try {
      isLoadingSuggestions(true);

      final client = HttpRequest(http.Client());

      final products = await ProductService(client).fetchFilteredProducts(
          keyword: keyword,
          minPrice: minPrice,
          maxPrice: maxPrice,
          categoryId: categoryId,
          pageNumber: pageNumber);
      productsByPage.value = products;
      print('haha');
    } catch (e) {
      Get.snackbar("Không tìm thấy", "Không có sản phẩm cần tìm",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSuggestions(false);
    }
  }
}
