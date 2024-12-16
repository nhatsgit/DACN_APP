import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/pages/Carts/my_carts.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:ecommerce_app/services/CustomHttpClient.dart';
import 'package:ecommerce_app/services/ProductServices.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailsPage extends StatefulWidget {
  final int productId; // Nhận productId từ tham số

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<ProductModel> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _fetchProductDetails(); // Gọi trực tiếp
  }

  Future<ProductModel> _fetchProductDetails() async {
    try {
      final product =
          await ProductService(CustomHttpClient(http.Client(), context))
              .fetchProductById(widget.productId);
      return product;
    } catch (error) {
      print('Lỗi khi fetch sản phẩm: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Chi tiết sản phẩm"),
      ),
      body: FutureBuilder<ProductModel>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Không tìm thấy sản phẩm."));
          }

          final product = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: product.anhDaiDien != null
                          ? Image.network(
                              '${ApiConfig.baseUrl}${product.anhDaiDien}',
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                      child: Icon(Icons.image, size: 200)),
                            )
                          : const Center(child: Icon(Icons.image, size: 50)),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: product.anhDaiDien != null
                          ? Image.network(
                              '${ApiConfig.baseUrl}${product.anhDaiDien}',
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                      child: Icon(Icons.image, size: 200)),
                            )
                          : const Center(child: Icon(Icons.image, size: 50)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  product.tenSp ?? "Tên sản phẩm",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Giá:${MyFormat.formatCurrency(MyCaculator.calculateDiscountedPrice(product.giaBan.toDouble(), product.phanTramGiam.toDouble()))}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Giảm giá: ${product.phanTramGiam ?? 0}%",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Mã sản phẩm: ${product.productId}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Xử lý thêm vào giỏ hàng
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCartsPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Colors.orange, // Background color
                    ),
                    child: const Text('Thêm vào giỏ hàng'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
