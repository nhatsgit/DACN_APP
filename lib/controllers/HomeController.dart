import 'package:ecommerce_app/services/CategoryServices.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var productSuggestions = <ProductModel>[].obs;
  var productSlider = <ProductModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  var isLoadingSuggestions = false.obs;
  var isLoadingSlider = false.obs;
  var isLoadingCategories = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSuggestions();
    fetchSlider();
    fetchCategories();
  }

  Future<void> fetchSuggestions() async {
    try {
      isLoadingSuggestions(true);
      final client = HttpRequest(http.Client());
      final products = await ProductService(client).fetchSuggestionsToday();
      productSuggestions.assignAll(products);
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải sản phẩm gợi ý: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSuggestions(false);
    }
  }

  Future<void> fetchSlider() async {
    try {
      isLoadingSlider(true);
      final client = HttpRequest(http.Client());
      final sliderProducts = await ProductService(client).fetchSlider();
      productSlider.assignAll(sliderProducts);
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải slider: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSlider(false);
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories(true);
      final client = HttpRequest(http.Client());
      final categories = await CategoryService(client).fetchCatetories();
      categoryList.assignAll(categories);
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải danh mục: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingCategories(false);
    }
  }
}
