import 'package:ecommerce_app/components/PageList.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/models/OrderModel.dart';
import 'package:ecommerce_app/models/PageListModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetails.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  //late Future<PageListModel<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    //_ordersFuture = _fetchMyOrders(); // Gọi trực tiếp
  }

  // Future<PageListModel<OrderModel>> _fetchMyOrders() async {
  //   try {
  //     final orders =
  //         await OrderService(CustomHttpClient(http.Client(), context))
  //             .fetchMyOrders();
  //     return orders;
  //   } catch (error) {
  //     print('Lỗi khi fetch đơn hang: $error');
  //     throw error;
  //   }
  // }

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
                    // Đơn hàng 1
                    Container(
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
                            'Ngày đặt: 11/12/2024',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://example.com/images/your_image.jpg"), // Cập nhật URL hợp lệ
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("San pham 1"),
                                  Text('x 1'),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "100000VND",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chờ xác nhận",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                              Text(
                                'Thành tiền: 100000VND',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        productId: 1,
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Xem chi tiết"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.home);
                                },
                                child: Text("Về trang chủ"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
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
                            'Ngày đặt: 11/12/2024',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${ApiConfig.baseUrl}/images/device (66).png'), // Cập nhật URL hợp lệ
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("San pham 1"),
                                  Text('x 1'),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "100000VND",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chờ xác nhận",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                              Text(
                                'Thành tiền: 100000VND',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        productId: 1,
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Xem chi tiết"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.home);
                                },
                                child: Text("Về trang chủ"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
