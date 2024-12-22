import 'package:ecommerce_app/components/PageList.dart';
import 'package:ecommerce_app/controllers/ProductsByCategoryController.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/components/Products/ProductList.dart';

class ProductsByCategoryPage extends StatelessWidget {
  final CategoryModel category;

  ProductsByCategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    Get.delete<ProductsByCategoryController>();
    final ProductsByCategoryController controller = Get.put(
        ProductsByCategoryController(categoryId: category.productCategoryId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Danh mục sản phẩm",
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
                } else if (controller.productsByPage.value == null) {
                  return const Center(child: Text('Không có sản phẩm.'));
                } else if (controller.productsByPage.value!.items.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm.'));
                } else {
                  return Column(
                    children: [
                      ListProduct(
                          title: "Danh mục: ${category.tenLoai}",
                          products: controller.productsByPage.value!.items),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PaginatedListView(
                          pageCount: controller
                              .productsByPage.value!.pageCount, // Tổng số trang
                          currentPage: controller.productsByPage.value!
                              .pageNumber, // Trang hiện tại
                          onPageChanged: (page) {
                            controller.fetchFilteredProducts(
                                categoryId: category.productCategoryId,
                                pageNumber: page);
                          },
                        ),
                      )
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
