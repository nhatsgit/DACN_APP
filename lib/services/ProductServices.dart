import 'dart:convert';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';

class ProductService {
  final CustomHttpClient _customHttpClient;

  ProductService(this._customHttpClient);

  Future<List<ProductModel>> fetchSuggestionsToday() async {
    final endpoint = 'Products/suggestionsToday';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> fetchSlider() async {
    final endpoint = 'Products/sliderBar';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    final endpoint = 'Products/$id'; // Ghép id vào URL
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body); // Parse JSON response
      return ProductModel.fromJson(data); // Chuyển JSON thành ProductModel
    } else {
      throw Exception('Failed to load product with ID $id');
    }
  }
}
