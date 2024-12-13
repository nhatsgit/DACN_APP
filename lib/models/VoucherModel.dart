class VoucherModel {
  int voucherId;
  String voucherCode;
  int phanTramGiam;
  DateTime ngayHetHan;
  int soLuongCon;
  int voucherCategoryId;
  int? giamToiDa;
  int donToiThieu;
  int? shopId;
  DateTime ngayBatDau;

  VoucherModel({
    required this.voucherId,
    required this.voucherCode,
    required this.phanTramGiam,
    required this.ngayHetHan,
    required this.soLuongCon,
    required this.voucherCategoryId,
    this.giamToiDa,
    required this.donToiThieu,
    this.shopId,
    required this.ngayBatDau,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      voucherId: json['voucherId'],
      voucherCode: json['voucherCode'],
      phanTramGiam: json['phanTramGiam'],
      ngayHetHan: DateTime.parse(json['ngayHetHan']),
      soLuongCon: json['soLuongCon'],
      voucherCategoryId: json['voucherCategoryId'],
      giamToiDa: json['giamToiDa'],
      donToiThieu: json['donToiThieu'],
      shopId: json['shopId'],
      ngayBatDau: DateTime.parse(json['ngayBatDau']),
    );
  }
}
