import 'package:ecommerce_app/controllers/ProductsByCategoryController.dart';
import 'package:ecommerce_app/controllers/ProductsByImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/components/Products/ProductList.dart';

class ProductsByImagePage extends StatelessWidget {
  final String imagePath;

  ProductsByImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Get.delete<ProductsByCategoryController>();
    final ProductsByImageController controller =
        Get.put(ProductsByImageController(categoryId: 1, imagePath: imagePath));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Kết quả tìm kiếm cho hình ảnh",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoadingSuggestions.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.productsImage.value == null) {
                  return const Center(child: Text('Không có sản phẩm.'));
                } else if (controller.productsImage.value!.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm.'));
                } else {
                  return Column(
                    children: [
                      ListProduct(
                          title: "Kết quả: ",
                          products: controller.productsImage.value),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
