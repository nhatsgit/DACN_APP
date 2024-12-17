class PaymentModel {
  final int paymentId;
  final String tenLoai;

  PaymentModel({
    required this.paymentId,
    required this.tenLoai,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['paymentId'],
      tenLoai: json['tenLoai'],
    );
  }
}
