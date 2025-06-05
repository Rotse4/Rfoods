import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/rating_controller.dart';
import '../../../models/Product.dart';
import 'rating_stars.dart';

class ReviewsList extends StatelessWidget {
  final Product product;

  const ReviewsList({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RatingController ratingController = Get.find<RatingController>();

    return GetBuilder<RatingController>(
      builder: (controller) {
        final reviews = controller.getRatingsForProduct(product.id);
        
        if (reviews.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews (${reviews.length})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (reviews.length > 3)
                    TextButton(
                      onPressed: () {
                        // Navigate to full reviews screen
                        // You can implement this later
                      },
                      child: const Text('View All'),
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              ...reviews.take(3).map((review) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            review.userName[0].toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.userName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  RatingStars(rating: review.rating, size: 14),
                                  const SizedBox(width: 8),
                                  Text(
                                    _formatDate(review.createdAt),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    if (review.comment.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        review.comment,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              )).toList(),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return 'Just now';
    }
  }
}