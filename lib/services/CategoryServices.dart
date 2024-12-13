import 'dart:convert';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';

class CategoryService {
  final CustomHttpClient _customHttpClient;

  CategoryService(this._customHttpClient);

  Future<List<CategoryModel>> fetchCatetories() async {
    final endpoint = 'Categories';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jsonItem) => CategoryModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
