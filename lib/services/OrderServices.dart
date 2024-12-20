import 'dart:convert';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/models/PageListModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';

class OrderService {
  final CustomHttpClient _customHttpClient;

  OrderService(this._customHttpClient);

  Future<OrderResponse> fetchMyOrders(int pageNumber) async {
    final endpoint = 'Orders?pageNumber=$pageNumber';
    final response = await _customHttpClient.get(endpoint);
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return OrderResponse.fromJson(data);
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<OrderModel> fetchOrderById(int id) async {
    final endpoint = 'Orders/$id';
    final response = await _customHttpClient.get(endpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return OrderModel.fromJson(data);
    } else {
      throw Exception('Failed to load orders with ID $id');
    }
  }
}
