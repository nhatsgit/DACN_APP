import 'package:ecommerce_app/components/ShoppingCart/CheckOutItem.dart';
import 'package:ecommerce_app/components/ShoppingCart/VoucherModal.dart';
import 'package:ecommerce_app/controllers/CheckOutController.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  final int shoppingCartId;

  CheckOutPage({super.key, required this.shoppingCartId});

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
                  return const Center(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tổng đơn hàng: ${MyFormat.formatCurrency(shoppingCart.getTotalPrice())}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                                Text(
                                  "Giảm giá đơn hàng: ${MyFormat.formatCurrency(controller.discountPrice.value)}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                                Text(
                                  "Tổng thanh toán: ${MyFormat.formatCurrency(shoppingCart.getTotalPrice() - controller.discountPrice.value)}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
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
                        RadioListTile<int>(
                          title: const Text('Thanh toán trực tiếp'),
                          value: 1,
                          groupValue: controller.paymentId.value,
                          onChanged: (value) => controller.setPaymentMethod(1),
                        ),
                        RadioListTile<int>(
                          title: const Text('Thanh toán online'),
                          value: 2,
                          groupValue: controller.paymentId.value,
                          onChanged: (value) => controller.setPaymentMethod(2),
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
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => VoucherModal(
                            vouchers: controller.voucherList,
                            totalPrice: controller.shoppingCart.value
                                    ?.getTotalPrice() ??
                                0,
                            onVoucherSelected: (selectedVoucher) {
                              controller.caculateDiscountPrice(selectedVoucher);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      child: Text('Chọn mã giảm giá'),
                    ),
                  ),
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
