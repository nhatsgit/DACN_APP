import 'package:ecommerce_app/components/Order/Order.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/controllers/MyOrdersController.dart';
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
            // Custom App Bar
            CustomAppBar(
              children: [
                Text(
                  "Đơn hàng",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Spacer(),
              ],
            ),

            // Nội dung phần dưới
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16), // Thêm padding
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  final orders = controller.orderByPage.value;

                  if (orders == null || orders.items.isEmpty) {
                    return const Text("Không tìm thấy sản phẩm.");
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap:
                            true, // Giới hạn kích thước ListView trong Column
                        physics:
                            NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn độc lập
                        itemCount: orders.items.length,
                        itemBuilder: (context, index) {
                          final item = orders.items[index];
                          return ListTile(
                            title: Order(
                              order: item,
                            ),
                          );
                        },
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical:
                                      8), // Khoảng cách từ văn bản đến viền
                              decoration: BoxDecoration(
                                color: Colors.blue, // Màu nền của nút
                                borderRadius: BorderRadius.zero, // Góc vuông
                              ),
                              child: Text(
                                '<',
                                style: TextStyle(
                                  color: Colors.white, // Màu chữ
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ])
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
