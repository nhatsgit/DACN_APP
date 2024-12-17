import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetailsPage.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends StatefulWidget {
  final CartItemModel cartItem;
  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(
                  () => ProductDetailsPage(
                    productId: widget.cartItem.product.productId,
                  ),
                );
              },
              child: Image.network(
                '${ApiConfig.baseUrl}${widget.cartItem.product.anhDaiDien}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.cartItem.product.tenSp ?? "Ten sp",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                ),
                Text(
                  "$quantity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${MyFormat.formatCurrency(MyCaculator.calculateDiscountedPrice(widget.cartItem.product.giaBan.toDouble(), widget.cartItem.product.phanTramGiam.toDouble()))}",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }
}
