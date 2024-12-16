import 'package:ecommerce_app/models/PaymetModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/models/VoucherModel.dart';

class OrderModel {
  int orderId;
  DateTime orderDate;
  double totalPrice;
  String? shippingAddress;
  String? notes; // Cho phép null
  List<OrderDetailModel> orderDetails;
  OrderStatusModel orderStatus;
  PaymentModel payment;
  UserInfoModel user;
  VoucherModel voucher;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
    required this.shippingAddress,
    this.notes, // Không bắt buộc
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
      totalPrice: (json['totalPrice'] as num).toDouble(),
      shippingAddress: json['shippingAddress'],
      notes: json['notes'], // Có thể null
      orderDetails: (json['orderDetails'] as List)
          .map((detail) => OrderDetailModel.fromJson(detail))
          .toList(),
      orderStatus: OrderStatusModel.fromJson(json['orderStatus']),
      payment: PaymentModel.fromJson(json['payment']),
      user: UserInfoModel.fromJson(json['user']),
      voucher: VoucherModel.fromJson(json['voucher']),
    );
  }
}

class OrderDetailModel {
  int id;
  int orderId;
  int quantity;
  double price; // Chuyển từ double sang int khi đọc từ JSON
  bool? isReview;
  ProductModel product;

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
      price: (json['price'] as num).toDouble(), // Chuyển đổi kiểu
      isReview: json['isReview'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}

class OrderStatusModel {
  int orderStatusId;
  String? tenTrangThai;

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
