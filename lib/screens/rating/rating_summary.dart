import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/rating_controller.dart';
import '../../../models/Product.dart';
import '../../../utils/constants.dart';
import 'rating_stars.dart';
import 'add_rating_dialog.dart';

class RatingSummary extends StatelessWidget {
  final Product product;

  const RatingSummary({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RatingController ratingController = Get.find<RatingController>();

    return GetBuilder<RatingController>(
      builder: (controller) {
        final averageRating = controller.getAverageRating(product.id);
        final totalRatings = controller.getRatingCount(product.id);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Customer Reviews',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddRatingDialog(product: product),
                      );
                    },
                    child: const Text('Add Review'),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              if (totalRatings > 0) ...[
                Row(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    RatingStars(rating: averageRating, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '($totalRatings reviews)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Rating breakdown
                ...List.generate(5, (index) {
                  final starCount = 5 - index;
                  final count = controller.getRatingsForProduct(product.id)
                      .where((rating) => rating.rating.round() == starCount)
                      .length;
                  final percentage = totalRatings > 0 ? count / totalRatings : 0.0;
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Text('$starCount'),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 8),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('$count'),
                      ],
                    ),
                  );
                }),
              ] else ...[
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No reviews yet',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Be the first to review this product!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}