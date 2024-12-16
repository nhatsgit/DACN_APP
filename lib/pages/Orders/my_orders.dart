import 'package:ecommerce_app/components/Order/Order.dart';
import 'package:ecommerce_app/components/PageList.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/controllers/MyOrdersController.dart';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/models/PageListModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetails.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final MyOrdersController controller = Get.put(MyOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomAppBar(
              children: [
                Text(
                  "Đơn hàng",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Spacer(),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16), // Thêm padding cho phần cuộn
                child: Column(
                  children: [
                    // Order(),
                    // Order(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
