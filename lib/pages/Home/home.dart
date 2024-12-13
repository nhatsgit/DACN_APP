import 'dart:async';
import 'package:ecommerce_app/components/Products/ListCategory.dart';
import 'package:ecommerce_app/components/Products/ListProduct.dart';
import 'package:ecommerce_app/components/Products/SliderProduct.dart';
import 'package:ecommerce_app/models/CategoryModel.dart';
import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/services/CategoryServices.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearchActive = false;
  late Future<List<ProductModel>> _productSuggestions = Future.value([]);
  late Future<List<ProductModel>> _productSlider = Future.value([]);
  late Future<List<CategoryModel>> _categoryList = Future.value([]);

  @override
  void initState() {
    super.initState();
    _fetchProductSuggestions();
  }

  Future<void> _fetchProductSuggestions() async {
    try {
      final products =
          await ProductService(CustomHttpClient(http.Client(), context))
              .fetchSuggestionsToday();
      final sliderProducts =
          await ProductService(CustomHttpClient(http.Client(), context))
              .fetchSlider();
      final categories =
          await CategoryService(CustomHttpClient(http.Client(), context))
              .fetchCatetories();
      setState(() {
        _productSlider = Future.value(sliderProducts);
        _productSuggestions = Future.value(products);
        _categoryList = Future.value(categories);
      });
    } catch (error) {
      print('Lỗi khi fetch sản phẩm: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder<List<ProductModel>>(
              future: _productSlider,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available'));
                } else {
                  return SliderProduct(products: snapshot.data!);
                }
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<CategoryModel>>(
              future: _categoryList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm.'));
                }

                return ListCategory(categories: snapshot.data!);
              },
            ),
            const SizedBox(height: 20),
            const Text("Gợi ý hôm nay",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            FutureBuilder<List<ProductModel>>(
              future: _productSuggestions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm.'));
                }

                return ListProduct(products: snapshot.data!);
              },
            ),
            const SizedBox(height: 20),
            const Text("mycarts"),
          ],
        ),
      ),
    );
  }
}
