class CategoryModel {
  final int productCategoryId;
  final String tenLoai;
  final String anhDaiDien;

  CategoryModel({
    required this.productCategoryId,
    required this.tenLoai,
    required this.anhDaiDien,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      productCategoryId: json['productCategoryId'],
      tenLoai: json['tenLoai'],
      anhDaiDien: json['anhDaiDien'],
    );
  }
}
