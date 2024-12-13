import 'package:ecommerce_app/models/PaymetModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/UserInfoModel.dart';
import 'package:ecommerce_app/models/VoucherModel.dart';

class OrderModel {
  int orderId;
  DateTime orderDate;
  int totalPrice;
  String shippingAddress;
  String notes;
  List<OrderDetail> orderDetails;
  OrderStatus orderStatus;
  PaymentModel payment;
  UserInfoModel user;
  VoucherModel voucher;

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
      orderDetails: (json['orderDetails'] as List)
          .map((detail) => OrderDetail.fromJson(detail))
          .toList(),
      orderStatus: OrderStatus.fromJson(json['orderStatus']),
      payment: PaymentModel.fromJson(json['payment']),
      user: UserInfoModel.fromJson(json['user']),
      voucher: VoucherModel.fromJson(json['voucher']),
    );
  }
}

class OrderDetail {
  int id;
  int orderId;
  int quantity;
  int price;
  bool? isReview;
  ProductModel product;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.price,
    this.isReview,
    required this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      orderId: json['orderId'],
      quantity: json['quantity'],
      price: json['price'],
      isReview: json['isReview'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}

class OrderStatus {
  int orderStatusId;
  String tenTrangThai;

  OrderStatus({
    required this.orderStatusId,
    required this.tenTrangThai,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      orderStatusId: json['orderStatusId'],
      tenTrangThai: json['tenTrangThai'],
    );
  }
}
