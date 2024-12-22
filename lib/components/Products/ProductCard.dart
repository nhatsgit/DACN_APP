import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetailsPage.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final int index;

  const ProductCard({required this.product, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductDetailsPage(
            productId: product.productId,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[200],
                width: double.infinity,
                child: Center(
                  child: product.anhDaiDien != null
                      ? Image.network(
                          '${ApiConfig.baseUrl}${product.anhDaiDien}', // Thay thế URL phù hợp nếu cần
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.image, size: 50)),
                        )
                      : const Icon(Icons.image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.tenSp}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Giá: ${MyFormat.formatCurrency(MyCaculator.calculateDiscountedPrice(product.giaBan.toDouble(), product.phanTramGiam.toDouble()))}", // Hiển thị giá bán
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Giảm giá: -${product.phanTramGiam}%",
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Mã sản phẩm: ${product.productId}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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
