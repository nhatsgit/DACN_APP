import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:flutter/material.dart';

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
        Image.network(
          '${ApiConfig.baseUrl}${widget.cartItem.product.anhDaiDien}',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.cartItem.product.tenSp,
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
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.cartItem.product.giaBan} VND",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
