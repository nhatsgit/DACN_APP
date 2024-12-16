import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controllers/HomeController.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/components/Products/ListCategory.dart';
import 'package:ecommerce_app/components/Products/ListProduct.dart';
import 'package:ecommerce_app/components/Products/SliderProduct.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              children: [
                Expanded(
                    child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Tìm kiếm...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                        style: const TextStyle(fontSize: 16)))
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

            const Text("Gợi ý hôm nay",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 20),
            const Text("mycarts"),
          ],
        ),
      ),
    );
  }
}
