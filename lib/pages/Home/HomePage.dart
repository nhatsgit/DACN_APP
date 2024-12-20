import 'package:ecommerce_app/pages/Shared/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controllers/HomeController.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/components/Products/CategoryList.dart';
import 'package:ecommerce_app/components/Products/ProductList.dart';
import 'package:ecommerce_app/components/Products/ProductSlider.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController _searchController = TextEditingController();

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

            // SliderProduct with GetX
            Obx(() {
              if (homeController.isLoadingSlider.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeController.productSlider.isEmpty) {
                return const Center(child: Text('No products available'));
              } else {
                return SliderProduct(products: homeController.productSlider);
              }
            }),
            const SizedBox(height: 20),

            // ListCategory with GetX
            Obx(() {
              if (homeController.isLoadingCategories.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeController.categoryList.isEmpty) {
                return const Center(child: Text('Không có sản phẩm.'));
              } else {
                return ListCategory(categories: homeController.categoryList);
              }
            }),
            const SizedBox(height: 20),

            // ListProduct with GetX
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
