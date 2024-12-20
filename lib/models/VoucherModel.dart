class VoucherModel {
  final int voucherId;
  final String voucherCode;
  final int phanTramGiam;
  final DateTime ngayHetHan;
  final int soLuongCon;
  final int? voucherCategoryId;
  final double? giamToiDa;
  final double? donToiThieu;
  final int? shopId;
  final DateTime? ngayBatDau;

  VoucherModel({
    required this.voucherId,
    required this.voucherCode,
    required this.phanTramGiam,
    required this.ngayHetHan,
    required this.soLuongCon,
    required this.voucherCategoryId,
    required this.giamToiDa,
    required this.donToiThieu,
    this.shopId,
    this.ngayBatDau,
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
      ngayBatDau: json['ngayBatDau'] != null
          ? DateTime.parse(json['ngayBatDau'])
          : null,
    );
  }
}
