import 'dart:async';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/pages/Product/ProductDetailsPage.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';

class SliderProduct extends StatefulWidget {
  final List<ProductModel> products;

  const SliderProduct({Key? key, required this.products}) : super(key: key);

  @override
  _SliderProductState createState() => _SliderProductState();
}

class _SliderProductState extends State<SliderProduct> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() => _currentPage = (_currentPage + 1) % 3);
      _pageController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.products.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.tenSp ?? "Ten SP",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product.moTa ?? "mota",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                              "${MyFormat.formatCurrency(MyCaculator.calculateDiscountedPrice(product.giaBan.toDouble(), product.phanTramGiam.toDouble()))}"),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  productId: product.productId,
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.info),
                            label: const Text("Xem Chi Tiết"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        width: 200,
                        height: 200,
                        child: product.anhDaiDien != null
                            ? Image.network(
                                '${ApiConfig.baseUrl}${product.anhDaiDien}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                        child: Icon(Icons.image, size: 50)),
                              )
                            : const Center(child: Icon(Icons.image, size: 50)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.products.length,
            (index) => GestureDetector(
              onTap: () {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                setState(() => _currentPage = index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(4),
                width: _currentPage == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
