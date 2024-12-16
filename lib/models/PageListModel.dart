class PageListModel<T> {
  List<T> items;
  final int pageNumber;
  final int pageSize;
  final int totalItemCount;
  final int pageCount;

  PageListModel({
    this.items = const [],
    required this.pageNumber,
    required this.pageSize,
    required this.totalItemCount,
    required this.pageCount,
  });

  factory PageListModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PageListModel(
      items: (json['items'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalItemCount: (json['totalItemCount'] as num).toInt(),
      pageCount: (json['pageCount'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => (item as dynamic).toJson()).toList(),
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalItemCount': totalItemCount,
      'pageCount': pageCount,
    };
  }
}
