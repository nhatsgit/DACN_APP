import 'package:ecommerce_app/components/Products/ProductImageSlider.dart';
import 'package:ecommerce_app/components/Products/ProductReviewsList.dart';
import 'package:ecommerce_app/controllers/ProductDetailsController.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    Get.delete<ProductDetailsController>();
    final ProductDetailsController controller =
        Get.put(ProductDetailsController(productId), permanent: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Chi tiết sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.product.value == null) {
          return const Center(
              child: Text(
                  "Không tìm thấy sản phẩm.Hãy kiểm tra lại kết nối mạng"));
        }

        final product = controller.product.value!;
        final images = controller.imageList.value!;
        final reviews = controller.reviewsList.value!;

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageSlider(
                    anhDaiDien: '${ApiConfig.baseUrl}${product.anhDaiDien}',
                    imageUrls: images
                        .map((image) => '${ApiConfig.baseUrl}${image.url}')
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.tenSp ?? "Tên sản phẩm",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Giá: ${MyFormat.formatCurrency(MyCaculator.calculateDiscountedPrice(product.giaBan.toDouble(), product.phanTramGiam.toDouble()))}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Giảm giá: ${product.phanTramGiam ?? 0}%",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: "Mã sản phẩm: ",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "${product.productId}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Số lượng còn: ",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "${product.soLuongCon}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: "Thông số: ",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "${product.thongSo}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: "Mô tả: ",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "${product.moTa}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text("Đánh giá sản phẩm",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  ),
                  ProductReviewList(reviews: reviews),
                  const SizedBox(height: 80),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          controller
                              .updateQuantity(controller.quantity.value - 1);
                        },
                      ),
                      Text(
                        "${controller.quantity.value}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          controller
                              .updateQuantity(controller.quantity.value + 1);
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.addToCart();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      'Thêm vào giỏ hàng',
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
