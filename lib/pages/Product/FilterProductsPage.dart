import 'package:ecommerce_app/controllers/FilterProductsController.dart';
import 'package:ecommerce_app/pages/Shared/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/components/Products/ProductList.dart';

class FilterProductsPage extends StatelessWidget {
  final FilterProductsController homeController =
      Get.put(FilterProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => {Get.to(SearchPage())},
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      side: BorderSide(color: Colors.black),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.black),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tìm kiếm...',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (homeController.isLoadingSuggestions.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeController.productSuggestions.isEmpty) {
                return const Center(child: Text('Không có sản phẩm.'));
              } else {
                return ListProduct(products: homeController.productSuggestions);
              }
            }),
          ],
        ),
      ),
    );
  }
}
