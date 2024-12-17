import 'package:ecommerce_app/components/Products/ProductCard.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final List<ProductModel> products;

  const ListProduct({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Gợi ý hôm nay",
            style: TextStyle(
                fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Padding(
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
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product, index: index);
            },
          ),
        )
      ],
    );
  }
}
