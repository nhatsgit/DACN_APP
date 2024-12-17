class ProductImageModel {
  final int productImageId;
  final String url;
  final int productId;

  ProductImageModel({
    required this.productImageId,
    required this.url,
    required this.productId,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      productImageId: json['productImageId'],
      url: json['url'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productImageId': productImageId,
      'url': url,
      'productId': productId,
    };
  }
}
