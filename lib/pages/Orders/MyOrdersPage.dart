import 'package:ecommerce_app/components/Order/Order.dart';
import 'package:ecommerce_app/components/PageList.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/controllers/MyOrdersController.dart';
import 'package:flutter/material.dart';
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
                padding: EdgeInsets.all(16),
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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                      PaginatedListView(
                        pageCount: orders.pageCount, // Tổng số trang
                        currentPage: orders.pageNumber, // Trang hiện tại
                        onPageChanged: (page) {
                          controller.fetchMyOrders(page);
                        },
                      ),
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
