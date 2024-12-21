import 'package:ecommerce_app/services/CategoryServices.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:http/http.dart' as http;

class FilterProductsController extends GetxController {
  var productSuggestions = <ProductModel>[].obs;
  var productSlider = <ProductModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  var isLoadingSuggestions = false.obs;
  var isLoadingSlider = false.obs;
  var isLoadingCategories = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductSuggestions();
  }

  Future<void> fetchProductSuggestions() async {
    try {
      isLoadingSuggestions(true);
      isLoadingSlider(true);
      isLoadingCategories(true);

      final client = Request(http.Client());

      final products = await ProductService(client).fetchSuggestionsToday();
      final sliderProducts = await ProductService(client).fetchSlider();
      final categories = await CategoryService(client).fetchCatetories();

      productSuggestions.assignAll(products);
      productSlider.assignAll(sliderProducts);
      categoryList.assignAll(categories);
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải dữ liệu: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSuggestions(false);
      isLoadingSlider(false);
      isLoadingCategories(false);
    }
  }
}
