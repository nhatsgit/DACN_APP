import 'package:ecommerce_app/models/ProductModel.dart';

class PageListProductModel {
  final List<ProductModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalItemCount;
  final int pageCount;

  PageListProductModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItemCount,
    required this.pageCount,
  });

  factory PageListProductModel.fromJson(Map<String, dynamic> json) {
    return PageListProductModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalItemCount: json['totalItemCount'],
      pageCount: json['pageCount'],
    );
  }
}
