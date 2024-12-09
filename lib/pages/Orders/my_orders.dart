import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomAppBar(children: [
            Text(
              "Đơn hàng",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
          ]),
          SingleChildScrollView(
            child: Column(
              children: [Text("myorder")],
            ),
          )
        ],
      ),
    );
  }
}
