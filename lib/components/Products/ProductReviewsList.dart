import 'package:ecommerce_app/models/ReviewsModel.dart';
import 'package:ecommerce_app/services/ApiConfig.dart';
import 'package:flutter/material.dart';

class ProductReviewList extends StatelessWidget {
  final List<ReviewsModel> reviews;

  const ProductReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviews.isEmpty
        ? const Center(child: Text("Chưa có đánh giá nào."))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${ApiConfig.baseUrl}${review.customer.avatar}'),
                            radius: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            review.customer.userName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        review.noiDung,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "${review.diemDanhGia}/5",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.amber),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(review.thoiGianDanhGia),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (review.reviewsImages.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: review.reviewsImages.length,
                            itemBuilder: (context, imageIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    review.reviewsImages[imageIndex],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.image,
                                                size: 50, color: Colors.grey),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
