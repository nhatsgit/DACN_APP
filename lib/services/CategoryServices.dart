import 'dart:convert';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';

class CategoryService {
  final Request _customHttpClient;

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

  Future<List<CategoryModel>> fetchCatetoriesFromFilter({
    String? keyword,
    int? brandId,
    int? shopId,
    double? minPrice,
    double? maxPrice,
    bool? daAn,
    bool? daHet,
  }) async {
    final endpoint = 'Products/getCategoriesFromQuerry?keyword=${keyword ?? ""}'
        '&brandId=${brandId ?? ""}'
        '&shopId=${shopId ?? ""}'
        '&minPrice=${minPrice ?? ""}'
        '&maxPrice=${maxPrice ?? ""}'
        '&daAn=${daAn ?? false}'
        '&daHet=${daHet ?? false}';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jsonItem) => CategoryModel.fromJson2(jsonItem)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
