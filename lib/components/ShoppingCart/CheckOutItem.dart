import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';

class CheckOutItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CheckOutItem({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            '${ApiConfig.baseUrl}${cartItem.product.anhDaiDien}',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.tenSp ?? "Máy tính",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'x${cartItem.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${MyFormat.formatCurrency(cartItem.quantity * MyCaculator.calculateDiscountedPrice(cartItem.product.giaBan, cartItem.product.phanTramGiam.toDouble()))}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
