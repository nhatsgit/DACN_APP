import 'package:ecommerce_app/services/MyProductServices.dart';
import 'package:ecommerce_app/services/Request.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/CategoryServices.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // State variables
  var productSuggestions = <ProductModel>[].obs;
  var productSlider = <ProductModel>[].obs;
  var categoryList = <CategoryModel>[].obs;

  // Loading state
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

      final client = MyHttp(http.Client(), Get.context!);

      final products = await MyProductService(client).fetchSuggestionsToday();
      final sliderProducts = await MyProductService(client).fetchSlider();
      final categories = await MyProductService(client).fetchCatetories();

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
