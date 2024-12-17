class ReviewsModel {
  final int reviewsId;
  final String noiDung;
  final int diemDanhGia;
  final DateTime thoiGianDanhGia;
  final int productId;
  final Customer customer;
  final List<String> reviewsImages;

  ReviewsModel({
    required this.reviewsId,
    required this.noiDung,
    required this.diemDanhGia,
    required this.thoiGianDanhGia,
    required this.productId,
    required this.customer,
    required this.reviewsImages,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      reviewsId: json['reviewsId'] as int,
      noiDung: json['noiDung'] as String,
      diemDanhGia: json['diemDanhGia'] as int,
      thoiGianDanhGia: DateTime.parse(json['thoiGianDanhGia'] as String),
      productId: json['productId'] as int,
      customer: Customer.fromJson(json['customer']),
      reviewsImages: (json['reviewsImages'] as List<dynamic>)
          .map((image) => image.toString())
          .toList(),
    );
  }
}

class Customer {
  final String userName;
  final String avatar;

  Customer({
    required this.userName,
    required this.avatar,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      userName: json['userName'] as String,
      avatar: json['avatar'] as String,
    );
  }
}
