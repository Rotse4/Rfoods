import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/rating_controller.dart';
import '../../../models/rating.dart';
import '../../../models/Product.dart';
import 'interactive_rating.dart';

class AddRatingDialog extends StatelessWidget {
  final Product product;

  const AddRatingDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RatingController ratingController = Get.find<RatingController>();
    final TextEditingController commentController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    double selectedRating = 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16), // Reduced from 20 to 16
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate this product',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Product info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.images.first,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Rating stars
                Text(
                  'Your Rating',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                InteractiveRating(
                  onRatingChanged: (rating) => selectedRating = rating,
                  size: 32,
                ),
                
                const SizedBox(height: 20),
                
                // Name input
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Comment input
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Your Review (Optional)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action buttons - FIXED OVERFLOW ISSUE
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedRating > 0 && nameController.text.isNotEmpty) {
                              final rating = Rating(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                productId: product.id.toString(),
                                userName: nameController.text,
                                userAvatar: 'assets/images/default_avatar.png',
                                rating: selectedRating,
                                comment: commentController.text,
                                createdAt: DateTime.now(),
                              );
                              
                              ratingController.addRating(rating);
                              Get.back();
                              Get.snackbar(
                                'Success',
                                'Your rating has been added!',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please provide a rating and your name',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}