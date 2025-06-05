import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/rating_controller.dart';
import '../../../models/Product.dart';
import '../../../models/rating.dart';

class RatingSummary extends StatelessWidget {
  final Product product;

  const RatingSummary({Key? key, required this.product}) : super(key: key);

  void _showAddReviewDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    double selectedRating = 0;
    
    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              "Add Review",
              style: TextStyle(fontSize: 20.sp),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SOLUTION 1: Wrap the Row with Flexible/Expanded
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max, // Changed from min to max
                      children: List.generate(5, (index) {
                        return Expanded( // Wrap each IconButton with Expanded
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                              minWidth: 30.w, // Reduced from 40.w to 30.w
                              minHeight: 40.h,
                            ),
                            icon: Icon(
                              index < selectedRating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 28.sp, // Reduced from 32.sp to 28.sp
                            ),
                            onPressed: () {
                              setState(() {
                                selectedRating = index + 1;
                              });
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  
                  // ALTERNATIVE SOLUTION 2: Use a different approach with GestureDetector
                  /*
                  Container(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            child: Icon(
                              index < selectedRating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 28.sp,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  */
                  
                  SizedBox(height: 16.h),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write your review...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding: EdgeInsets.all(12.w),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedRating > 0 && commentController.text.isNotEmpty) {
                    final RatingController ratingController = Get.find<RatingController>();
                    ratingController.addRating(
                      Rating(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        productId: product.id.toString(),
                        userName: "Current User", // You might want to get this from your auth system
                        userAvator: "assets/images/user1.png", // Default avatar
                        rating: selectedRating,
                        comment: commentController.text,
                        createdAt: DateTime.now().toString(),
                      ),
                    );
                    Get.back();
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RatingController ratingController = Get.find<RatingController>();
    
    return GetBuilder<RatingController>(
      builder: (controller) {
        final averageRating = controller.getAverageRating(product.id);
        final totalRatings = controller.getRatingCount(product.id);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rating Summary",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddReviewDialog(context),
                  icon: Icon(Icons.rate_review, size: 20.sp),
                  label: Text(
                    "Add Review",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            if (totalRatings > 0) ...[
              Row(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            return Icon(
                              index < averageRating.floor()
                                  ? Icons.star
                                  : index < averageRating.ceil()
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: Colors.amber,
                              size: 20.sp,
                            );
                          }),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "$totalRatings ratings",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ] else ...[
              InkWell(
                onTap: () => _showAddReviewDialog(context),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.rate_review, size: 24.sp, color: Colors.grey[600]),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "Be the first to review this product",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}