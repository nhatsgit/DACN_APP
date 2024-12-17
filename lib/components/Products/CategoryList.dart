import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetailsPage.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatelessWidget {
  final List<CategoryModel> categories;

  const ListCategory({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Danh mục sản phẩm",
            style: TextStyle(
                fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: categories.length,
            itemBuilder: (context, pageIndex) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsPage(productId: 1)),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: categories[index].anhDaiDien != null &&
                                        categories[index].anhDaiDien.isNotEmpty
                                    ? Image.network(
                                        '${ApiConfig.baseUrl}${categories[index].anhDaiDien}',
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                                    child: Icon(Icons.image,
                                                        size: 50)),
                                      )
                                    : const Icon(Icons.image,
                                        size:
                                            50), // Hiển thị icon nếu không có ảnh
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(categories[index].tenLoai,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.blue)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
