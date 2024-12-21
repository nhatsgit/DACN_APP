import 'package:ecommerce_app/components/CustomRichText.dart';
import 'package:ecommerce_app/components/Order/Order.dart';
import 'package:ecommerce_app/components/Order/OrderDetail.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/controllers/OrderDetailsController.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  final int orderId;

  OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    Get.delete<OrderDetailsController>();

    final OrderDetailsController controller =
        Get.put(OrderDetailsController(orderId), permanent: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Chi tiết đơn hàng",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = controller.order.value;

        if (order == null) {
          return const Center(child: Text("Không tìm thấy đơn hàng."));
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.orderDetails.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OrderDetail(orderDetail: order.orderDetails[index]),
                            if (order.orderStatus?.orderStatusId == 5 &&
                                order.orderDetails[index].isReview != true)
                              ElevatedButton(
                                child: const Text("Đánh giá"),
                                onPressed: () {},
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomRichText(
                        text1: "Ngày đặt: ",
                        text2: MyFormat.formatDateTime(order.orderDate),
                        fontSize: 22),
                    CustomRichText(
                        text1: "Địa chỉ giao hàng: ",
                        text2: order.shippingAddress,
                        fontSize: 22),
                    CustomRichText(
                        text1: "Phương thức thanh toán: ",
                        text2: order.payment?.tenLoai ?? "Trực tiếp",
                        fontSize: 22),
                    CustomRichText(
                        text1: "Tên người đặt: ",
                        text2: order.user.fullName,
                        fontSize: 22),
                    CustomRichText(
                        text1: "Số điện thoại: ",
                        text2: order.user.phoneNumber,
                        fontSize: 22),
                    CustomRichText(
                        text1: "Ghi chú: ",
                        text2: order.notes ?? order.user.phoneNumber,
                        fontSize: 22),
                    CustomRichText(
                        text1: "Mã giảm giá: ",
                        text2: order.voucher!.phanTramGiam > 0
                            ? "Mã ${order.voucher?.voucherCode} Giảm:${order.voucher?.phanTramGiam}% ${order.voucher!.donToiThieu! > 0 ? 'Đơn tối thiểu:  ${MyFormat.formatCurrency(order.voucher!.donToiThieu ?? 0)}' : ' '} ${order.voucher!.giamToiDa! > 0 ? 'Giảm tối đa: ${MyFormat.formatCurrency(order.voucher!.giamToiDa ?? 0)}' : ' '}  "
                            : 'Không có',
                        fontSize: 22),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tổng đơn hàng: ${MyFormat.formatCurrency(order.totalPrice)}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      Text(
                        "${order.orderStatus?.tenTrangThai}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        "Hủy đơn hàng",
                        "Đơn hàng của bạn đã được hủy.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      "Hủy Đơn",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
