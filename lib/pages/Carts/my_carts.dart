import 'package:ecommerce_app/components/ShoppingCart/CartItem.dart';
import 'package:ecommerce_app/components/ShoppingCart/ShoppingCart.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/models/ShoppingCartModel.dart';
import 'package:ecommerce_app/pages/Shared/CheckoutPage.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ShoppingCartServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCartsPage extends StatefulWidget {
  const MyCartsPage({super.key});

  @override
  State<MyCartsPage> createState() => _MyCartsPageState();
}

class _MyCartsPageState extends State<MyCartsPage> {
  // Initial product data
  late Future<List<ShoppingCartModel>> _myShoppingCart = Future.value([]);

  @override
  void initState() {
    super.initState();
    _fetchProductSuggestions();
  }

  Future<void> _fetchProductSuggestions() async {
    try {
      final shoppingcarts =
          await ShoppingCartService(CustomHttpClient(http.Client(), context))
              .fetchMyShoppingCarts();
      setState(() {
        _myShoppingCart = Future.value(shoppingcarts);
      });
    } catch (error) {
      print('Lỗi khi fetch sản phẩm: $error');
    }
  }

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
          ]),
          Expanded(
            child: FutureBuilder<List<ShoppingCartModel>>(
              future: _myShoppingCart,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Không tìm thấy sản phẩm."));
                }

                final myShoppingCarts = snapshot.data!;
                return ListView.builder(
                  itemCount: myShoppingCarts.length,
                  itemBuilder: (context, index) {
                    return ShoppingCartWidget(
                        shoppingCart: myShoppingCarts[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng đơn hàng: 500 VND",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()),
                    );
                  },
                  child: Text(
                    "Đặt hàng",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
