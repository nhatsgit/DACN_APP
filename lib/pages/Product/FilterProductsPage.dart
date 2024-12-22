import 'package:ecommerce_app/components/Products/FilterDrawer.dart';
import 'package:ecommerce_app/components/PageList.dart';
import 'package:ecommerce_app/controllers/FilterProductsController.dart';
import 'package:ecommerce_app/pages/Shared/SearchPage.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:ecommerce_app/components/Products/ProductList.dart';

class FilterProductsPage extends StatelessWidget {
  final String keyword;

  FilterProductsPage({required this.keyword});

  @override
  Widget build(BuildContext context) {
    final FilterProductsController controller =
        Get.put(FilterProductsController(keyword: keyword));

    return Scaffold(
      endDrawer: FilterDrawer(
        categories: controller.categoryList,
        onClearFilters: () {
          Navigator.of(context).pop();
        },
        onApplyFilters: (selectedCategoryId, minPrice, maxPrice) => {
          controller.fetchFilteredProducts(
              keyword: keyword,
              categoryId: selectedCategoryId,
              minPrice: minPrice,
              maxPrice: maxPrice,
              pageNumber: 1),
          Navigator.of(context).pop(),
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.offAll(MainPage()),
                  ),
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
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.filter_alt_outlined,
                            color: Colors.white),
                        onPressed: () {
                          final scaffold = Scaffold.of(context);
                          scaffold.openEndDrawer();
                        },
                      );
                    },
                  ),
                ],
              ),
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
                          title: "Kết quả tìm kiếm cho: $keyword",
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
                                keyword: keyword, pageNumber: page);
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
