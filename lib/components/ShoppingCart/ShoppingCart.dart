import 'package:ecommerce_app/components/ShoppingCart/CartItem.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:flutter/material.dart';

class ShoppingCartWidget extends StatelessWidget {
  final ShoppingCartModel shoppingCart;

  const ShoppingCartWidget({Key? key, required this.shoppingCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tên shop: ${shoppingCart.shop.tenCuaHang}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Column(
            children: shoppingCart.cartItems
                .map((cartItem) => CartItem(cartItem: cartItem))
                .toList(),
          ),
        ],
      ),
    );
  }
}
