import 'package:ecommerce_app/models/OrderModel.dart';

class PageListOrderModel {
  final List<OrderModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalItemCount;
  final int pageCount;

  PageListOrderModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItemCount,
    required this.pageCount,
  });

  factory PageListOrderModel.fromJson(Map<String, dynamic> json) {
    return PageListOrderModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalItemCount: json['totalItemCount'],
      pageCount: json['pageCount'],
    );
  }
}
