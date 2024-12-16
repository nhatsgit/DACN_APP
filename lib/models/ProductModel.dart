class ProductModel {
  final int productId;
  final String? tenSp;
  final String? anhDaiDien;
  final String? moTa;
  final String? thongSo;
  final double giaNhap;
  final double giaBan;
  final int soLuongCon;
  final int phanTramGiam;
  final double? diemDanhGia;
  final String? maSp;
  final bool? daAn;
  final int productCategoryId;
  final int brandId;
  final int shopId;

  ProductModel({
    required this.productId,
    required this.tenSp,
    required this.anhDaiDien,
    required this.moTa,
    required this.thongSo,
    required this.giaNhap,
    required this.giaBan,
    required this.soLuongCon,
    required this.phanTramGiam,
    this.diemDanhGia,
    this.maSp,
    required this.daAn,
    required this.productCategoryId,
    required this.brandId,
    required this.shopId,
  });

  // Factory constructor to create a Product from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      tenSp: json['tenSp'],
      anhDaiDien: json['anhDaiDien'],
      moTa: json['moTa'],
      thongSo: json['thongSo'],
      giaNhap: json['giaNhap'].toDouble(),
      giaBan: json['giaBan'].toDouble(),
      soLuongCon: json['soLuongCon'],
      phanTramGiam: json['phanTramGiam'],
      diemDanhGia:
          json['diemDanhGia'] != null ? json['diemDanhGia'].toDouble() : null,
      maSp: json['maSp'],
      daAn: json['daAn'],
      productCategoryId: json['productCategoryId'],
      brandId: json['brandId'],
      shopId: json['shopId'],
    );
  }
  @override
  String toString() {
    return 'Product{id: $productId, name: $tenSp, price: $giaBan, quantity: $soLuongCon}';
  }
}
