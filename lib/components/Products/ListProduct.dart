import 'package:ecommerce_app/components/Products/ProductCard.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final List<ProductModel> products;

  const ListProduct({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length, // Đếm số lượng sản phẩm
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
              product: product, index: index); // Gọi widget ProductCard
        },
      ),
    );
  }
}
