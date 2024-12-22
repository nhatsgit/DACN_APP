import 'dart:convert';
import 'package:ecommerce_app/models/PageListProductModel.dart';
import 'package:ecommerce_app/models/ProductImageModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/ReviewsModel.dart';
import 'package:ecommerce_app/services/HttpRequest.dart';

class ProductService {
  final HttpRequest _request;

  ProductService(this._request);

  Future<List<ProductModel>> fetchSuggestionsToday() async {
    final endpoint = 'Products/suggestionsToday';
    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> fetchSlider() async {
    final endpoint = 'Products/sliderBar';
    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    final endpoint = 'Products/$id';
    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load product with ID $id');
    }
  }

  Future<List<ProductImageModel>> fetchImagesProductById(int id) async {
    final endpoint = 'Products/productImage/$id';
    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((jsonItem) => ProductImageModel.fromJson(jsonItem))
          .toList();
    } else {
      throw Exception('Failed to load product images with ID $id');
    }
  }

  Future<List<ReviewsModel>> fetchReviewsProductById(int id) async {
    final endpoint = 'Reviews/ProductReviews?productId=$id';
    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((jsonItem) => ReviewsModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load product images with ID $id');
    }
  }

  Future<List<String>> getSearchSuggestions(String keyword) async {
    final endpoint = 'Products/searchSuggestions?keyword=${keyword}';
    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.cast<String>();
    } else {
      throw Exception('Failed to load search suggestions for keyword $keyword');
    }
  }

  Future<PageListProductModel> fetchFilteredProducts({
    String? keyword,
    int? categoryId,
    int? brandId,
    int? shopId,
    double? minPrice,
    double? maxPrice,
    bool? daAn,
    bool? daHet,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final endpoint = 'Products/query?keyword=${keyword ?? ""}'
        '&categoryId=${categoryId ?? ""}'
        '&brandId=${brandId ?? ""}'
        '&shopId=${shopId ?? ""}'
        '&minPrice=${minPrice ?? ""}'
        '&maxPrice=${maxPrice ?? ""}'
        '&daAn=${daAn ?? false}'
        '&daHet=${daHet ?? false}'
        '&pageNumber=$pageNumber'
        '&pageSize=$pageSize';

    final response = await _request.get(endpoint);

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      return PageListProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load filtered products');
    }
  }
}
