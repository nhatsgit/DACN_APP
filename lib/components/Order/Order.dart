import 'package:ecommerce_app/components/Order/OrderDetail.dart';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetailsPage.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
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
            'Ngày đặt: ${MyFormat.formatDateTime(order.orderDate)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.orderDetails.length,
            itemBuilder: (context, index) {
              return OrderDetail(orderDetail: order.orderDetails[index]);
            },
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Thành tiền: ${MyFormat.formatCurrency(order.totalPrice)}',
                style: const TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                order.orderStatus?.tenTrangThai ?? "Lỗi",
                style: const TextStyle(color: Colors.red, fontSize: 15),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                child: const Text("Xem chi tiết"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
