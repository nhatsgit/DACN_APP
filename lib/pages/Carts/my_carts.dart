import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyCartsPage extends StatefulWidget {
  const MyCartsPage({super.key});

  @override
  State<MyCartsPage> createState() => _MyCartsPageState();
}

class _MyCartsPageState extends State<MyCartsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomAppBar(children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
          ]),
          SingleChildScrollView(
            child: Column(
              children: [Text("mycarts")],
            ),
          )
        ],
      ),
    );
  }
}
