import 'package:ecommerce_app/services/HttpRequest.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchBarController extends GetxController {
  var searchHistory = <String>[].obs;
  var suggestions = <String>[].obs;
  var isLoading = false.obs;

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory.value = prefs.getStringList('searchhistory') ?? [];
  }

  Future<void> saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    if (searchHistory.length > 5) {
      searchHistory.removeAt(5);
    }
    await prefs.setStringList('searchhistory', searchHistory);
  }

  void addSearchTerm(String term) {
    if (!searchHistory.contains(term)) {
      searchHistory.insert(0, term);
      saveSearchHistory();
    }
  }

  Future<void> fetchSuggestions(String keyword) async {
    if (keyword.isEmpty) {
      suggestions.clear();
      return;
    }
    isLoading.value = true;
    try {
      final fetchedSuggestions =
          await ProductService(HttpRequest(http.Client()))
              .getSearchSuggestions(keyword);
      suggestions.value = fetchedSuggestions;
    } catch (e) {
      suggestions.clear();
      print("Error fetching suggestions: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
