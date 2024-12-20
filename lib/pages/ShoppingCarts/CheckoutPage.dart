import 'package:ecommerce_app/components/ShoppingCart/CheckOutItem.dart';
import 'package:ecommerce_app/controllers/CheckOutController.dart';
import 'package:ecommerce_app/pages/Orders/MyOrdersPage.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  final int shoppingCartId;

  CheckOutPage({super.key, required this.shoppingCartId});
  final List<Map<String, String>> discountCodes = [
    {"code": "SALE10", "description": "Giảm 10% đơn hàng"},
    {"code": "FREESHIP", "description": "Miễn phí vận chuyển"},
    {"code": "BUY1GET1", "description": "Mua 1 tặng 1"},
  ];

  @override
  Widget build(BuildContext context) {
    final CheckOutController controller =
        Get.put(CheckOutController(shoppingCartId), permanent: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () {
                final shoppingCart = controller.shoppingCart.value;
                if (shoppingCart == null) {
                  return Center(
                    child: Text("Giỏ hàng đang trống hoặc đang tải..."),
                  );
                }
                return Column(
                  children: [
                    Column(
                      children: shoppingCart.cartItems
                          .map((cartItem) => CheckOutItem(
                                cartItem: cartItem,
                              ))
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Tổng đơn hàng: ${MyFormat.formatCurrency(shoppingCart.getTotalPrice())}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) => controller.address.value = value,
                    decoration: InputDecoration(
                      labelText: 'Địa chỉ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) => controller.note.value = value,
                    decoration: InputDecoration(
                      labelText: 'Ghi chú',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Phương thức thanh toán',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        RadioListTile<String>(
                          title: Text('Thanh toán online'),
                          value: 'online',
                          groupValue: controller.paymentMethod.value,
                          onChanged: (value) =>
                              controller.setPaymentMethod(value ?? 'online'),
                        ),
                        RadioListTile<String>(
                          title: Text('Thanh toán trực tiếp'),
                          value: 'cash',
                          groupValue: controller.paymentMethod.value,
                          onChanged: (value) =>
                              controller.setPaymentMethod(value ?? 'cash'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Chọn mã giảm giá'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: discountCodes.map((discount) {
                                return ListTile(
                                  title: Text(discount['code']!),
                                  subtitle: Text(discount['description']!),
                                  onTap: () {},
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      child: Text('Chọn mã giảm giá'),
                    ),
                  ),
                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        controller.checkOut();
                      },
                      child: Text('Xác nhận thanh toán'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
