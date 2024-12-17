import 'package:ecommerce_app/models/PaymetModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/models/VoucherModel.dart';

class OrderResponse {
  final List<OrderModel> items;
  final int pageNumber;
  final int pageSize;
  final int totalItemCount;
  final int pageCount;

  OrderResponse({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItemCount,
    required this.pageCount,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
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

class OrderModel {
  final int orderId;
  final DateTime orderDate;
  final double totalPrice;
  final String shippingAddress;
  final String? notes;
  final List<OrderDetailModel> orderDetails;
  final OrderStatusModel? orderStatus;
  final PaymentModel? payment;
  final UserInfoModel user;
  final VoucherModel? voucher;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
    required this.shippingAddress,
    required this.notes,
    required this.orderDetails,
    required this.orderStatus,
    required this.payment,
    required this.user,
    required this.voucher,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalPrice: json['totalPrice'],
      shippingAddress: json['shippingAddress'],
      notes: json['notes'],
      orderDetails: (json['orderDetails'] as List<dynamic>)
          .map((e) => OrderDetailModel.fromJson(e))
          .toList(),
      orderStatus: json['orderStatus'] != null
          ? OrderStatusModel.fromJson(json['orderStatus'])
          : null,
      payment: json['payment'] != null
          ? PaymentModel.fromJson(json['payment'])
          : null,
      user: UserInfoModel.fromJson(json['user']),
      voucher: json['voucher'] != null
          ? VoucherModel.fromJson(json['voucher'])
          : null,
    );
  }
}

class OrderDetailModel {
  final int id;
  final int orderId;
  final int quantity;
  final double price;
  final bool? isReview;
  final ProductModel product;

  OrderDetailModel({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.price,
    this.isReview,
    required this.product,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'],
      orderId: json['orderId'],
      quantity: json['quantity'],
      price: json['price'],
      isReview: json['isReview'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}

class OrderStatusModel {
  final int orderStatusId;
  final String tenTrangThai;

  OrderStatusModel({
    required this.orderStatusId,
    required this.tenTrangThai,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      orderStatusId: json['orderStatusId'],
      tenTrangThai: json['tenTrangThai'],
    );
  }
}
