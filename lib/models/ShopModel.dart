class ShopModel {
  final int shopId;
  final String? tenCuaHang;
  final String? diaChi;
  final String? lienHe;
  final String? anhDaiDien;
  final String? anhBia;
  final String? ngayTao;
  final String? moTa;
  final int shopCategoryId;
  final dynamic biChan;

  ShopModel({
    required this.shopId,
    required this.tenCuaHang,
    required this.diaChi,
    required this.lienHe,
    required this.anhDaiDien,
    required this.anhBia,
    required this.ngayTao,
    required this.moTa,
    required this.shopCategoryId,
    this.biChan,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      shopId: json['shopId'],
      tenCuaHang: json['tenCuaHang'],
      diaChi: json['diaChi'],
      lienHe: json['lienHe'],
      anhDaiDien: json['anhDaiDien'],
      anhBia: json['anhBia'],
      ngayTao: json['ngayTao'],
      moTa: json['moTa'],
      shopCategoryId: json['shopCategoryId'],
      biChan: json['biChan'],
    );
  }
}
