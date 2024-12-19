import 'package:ecommerce_app/components/ShoppingCart/CartItem.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/pages/ShoppingCarts/CheckoutPage.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Tổng thanh toán:${MyFormat.formatCurrency(shoppingCart.getTotalPrice())} ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  Get.to(() => CheckOutPage(
                        shoppingCartId: shoppingCart.shoppingCartId,
                      ));
                },
                child: const Text(
                  "Đặt hàng",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
