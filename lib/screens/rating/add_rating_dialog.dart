import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/rating_controller.dart';
import '../../../models/rating.dart';
import '../../../models/Product.dart';
import '../../../utils/currency_formatter.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9.w,
          maxHeight: MediaQuery.of(context).size.height * 0.8.h,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate this product',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                
                // Product info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        product.images.first,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            CurrencyFormatter.formatKES(product.price),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20.h),
                
                // Rating stars
                Text(
                  'Your Rating',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                InteractiveRating(
                  onRatingChanged: (rating) => selectedRating = rating,
                  size: 32.sp,
                ),
                
                SizedBox(height: 20.h),
                
                // Name input
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Comment input
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Your Review (Optional)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                // Action buttons - FIXED OVERFLOW ISSUE
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedRating > 0 && nameController.text.isNotEmpty) {
                              final rating = Rating(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                productId: product.id.toString(),
                                userName: nameController.text,
                                userAvator: 'assets/images/default_avatar.png',
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
                                textDirection: TextDirection.ltr,
                                snackbarStyle: SnackbarStyle.FLOATING,
                                margin: EdgeInsets.all(10.w),
                                padding: EdgeInsets.all(10.w),
                                borderRadius: 10.r,
                                fontSize: 16.sp
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please provide a rating and your name',
                                snackPosition: SnackPosition.BOTTOM,
                                textDirection: TextDirection.ltr,
                                snackbarStyle: SnackbarStyle.FLOATING,
                                margin: EdgeInsets.all(10.w),
                                padding: EdgeInsets.all(10.w),
                                borderRadius: 10.r,
                                fontSize: 16.sp
                              );
                            }
                          },
                          child: Text('Submit', style: TextStyle(fontSize: 16.sp)),
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