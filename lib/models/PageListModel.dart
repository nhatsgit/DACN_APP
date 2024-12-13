class PageListModel<T> {
  final List<T> items;
  final int pageNumber;
  final int pageSize;
  final int totalItemCount;
  final int pageCount;

  PageListModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItemCount,
    required this.pageCount,
  });

  // Tạo một factory constructor để chuyển từ JSON sang đối tượng Dart
  factory PageListModel.fromJson(Map<String, dynamic> json) {
    return PageListModel(
      items: json['items'] ?? [],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalItemCount: json['totalItemCount'],
      pageCount: json['pageCount'],
    );
  }

  // Chuyển đối tượng Dart thành JSON
  Map<String, dynamic> toJson() {
    return {
      'items': items,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalItemCount': totalItemCount,
      'pageCount': pageCount,
    };
  }
}
