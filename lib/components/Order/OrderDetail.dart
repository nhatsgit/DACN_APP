import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final OrderDetailModel orderDetail;

  const OrderDetail({super.key, required this.orderDetail});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      '${ApiConfig.baseUrl}${orderDetail.product.anhDaiDien}'), // Cập nhật URL hợp lệ
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${orderDetail.product.tenSp}"),
                Text(
                  "${MyFormat.formatCurrency(orderDetail.price)}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('x${orderDetail.quantity}'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
