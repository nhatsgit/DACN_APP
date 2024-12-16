import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final OrderDetailModel orderDetail;

  const OrderDetail({super.key, required this.orderDetail});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  '${ApiConfig.baseUrl}/images/device (66).png'), // Cập nhật URL hợp lệ
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("San pham 1"),
            Text('x 1'),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "100000VND",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
