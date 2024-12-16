import 'package:ecommerce_app/components/Order/OrderDetail.dart';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetails.dart';
import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  final OrderModel order;

  const Order({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ngày đặt: ${order.orderDate}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          OrderDetail(
            orderDetail: order.orderDetails[0],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderStatus.tenTrangThai ?? "Lỗi",
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              Text(
                'Thành tiền: ${order.totalPrice}',
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productId: 1,
                      ),
                    ),
                  );
                },
                child: Text("Xem chi tiết"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
