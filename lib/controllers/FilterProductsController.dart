import 'package:ecommerce_app/models/PageListProductModel.dart';
import 'package:ecommerce_app/services/CategoryServices.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:http/http.dart' as http;

class FilterProductsController extends GetxController {
  final productsByPage = Rxn<PageListProductModel>();

  var productSlider = <ProductModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  var isLoadingSuggestions = false.obs;
  var isLoadingSlider = false.obs;
  var isLoadingCategories = false.obs;
  final String keyword;

  FilterProductsController({required this.keyword});

  @override
  void onInit() {
    super.onInit();
    fetchFilteredProducts(keyword: keyword, pageNumber: 1);
    fetchCategories(keyword: keyword);
  }

  Future<void> fetchFilteredProducts(
      {String? keyword,
      int? categoryId,
      double? minPrice,
      double? maxPrice,
      required int pageNumber}) async {
    try {
      isLoadingSuggestions(true);

      final client = Request(http.Client());

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

  Future<void> fetchCategories(
      {String? keyword, double? minPrice, double? maxPrice}) async {
    try {
      isLoadingSuggestions(true);

      final client = Request(http.Client());
      final categories = await CategoryService(client)
          .fetchCatetoriesFromFilter(keyword: keyword);
      categoryList.value = categories;
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải dữ liệu: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSuggestions(false);
    }
  }
}
