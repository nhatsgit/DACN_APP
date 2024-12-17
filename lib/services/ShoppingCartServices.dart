import 'dart:convert';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';

class ShoppingCartService {
  final CustomHttpClient _customHttpClient;

  ShoppingCartService(this._customHttpClient);

  Future<List<ShoppingCartModel>> fetchMyShoppingCarts() async {
    final endpoint = 'ShoppingCart';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((jsonItem) => ShoppingCartModel.fromJson(jsonItem))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<String> AddToCart(int productId, int quantity) async {
    final endpoint = 'ShoppingCart/addToCart';
    final body = {
      'productId': productId,
      'quantity': quantity,
    };

    final response = await _customHttpClient.post(endpoint, body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to addtocart: ${response.statusCode}');
    }
  }
}
