import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
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
                      fontSize: 18.sp,
                    ),
                  ),
                  if (reviews.length > 3)
                    TextButton(
                      onPressed: () {
                        // Navigate to full reviews screen
                        // You can implement this later
                      },
                      child: Text('View All', style: TextStyle(fontSize: 14.sp)),
                    ),
                ],
              ),
              
              SizedBox(height: 12.h),
              
              ...reviews.take(3).map((review) => Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            review.userName[0].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.userName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  RatingStars(rating: review.rating, size: 14.sp),
                                  SizedBox(width: 8.w),
                                  Text(
                                    _formatDate(review.createdAt),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 12.sp,
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
                      SizedBox(height: 8.h),
                      Text(
                        review.comment,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
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