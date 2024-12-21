import 'dart:convert';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/models/VoucherModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';

class ShoppingCartService {
  final Request _customHttpClient;

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

  Future<List<VoucherModel>> fetchVoucherByShopId(int shopId) async {
    final endpoint = 'Vouchers?shopId=${shopId}';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((jsonItem) => VoucherModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load vouchers');
    }
  }

  Future<String> addToCart(int productId, int quantity) async {
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

  Future<int> checkOut(int voucherId, int paymentId, String shippingAddress,
      String note, int shoppingCartId) async {
    final endpoint = 'ShoppingCart/checkOut?shoppingCartId=${shoppingCartId}';
    final body = {
      'voucherId': voucherId,
      'paymentId': paymentId,
      'shippingAddress': shippingAddress,
      'notes': note,
    };

    final response = await _customHttpClient.post(endpoint, body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      int orderId = data['orderId'];
      return orderId;
    } else {
      throw Exception('Failed to checkout: ${response.statusCode}');
    }
  }

  Future<String> deleteCartItemById(int cartItemId) async {
    final endpoint = 'ShoppingCart/deleteItem?cartItemId=${cartItemId}';
    final response = await _customHttpClient.post(endpoint, null);

    if (response.statusCode == 200) {
      return "Xóa thành công";
    } else {
      throw Exception('Failed to delete: ${response.statusCode}');
    }
  }

  Future<ShoppingCartModel> fetchShoppingCartById(int id) async {
    final endpoint = 'ShoppingCart/$id';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ShoppingCartModel.fromJson(data);
    } else {
      throw Exception('Failed to load cart with ID $id');
    }
  }
}
