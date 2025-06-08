import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil
import '../utils/constants.dart';
import '../models/Product.dart';
import '../controllers/product_controller.dart'; // Import controller
import '../utils/currency_formatter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
        Get.find<ProductController>(); // Access controller

    return SizedBox(
      width: width.w, // Apply .w for responsive width
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: EdgeInsets.all(20.w), // Apply .w for responsive padding
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r), // Apply .r for responsive border radius
                ),
                child: Image.asset(product.images[0]),
              ),
            ),
            SizedBox(height: 8.h), // Apply .h for responsive height
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CurrencyFormatter.formatKES(product.price),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Obx(
                  () => InkWell(
                    // Use Obx for reactive UI
                    borderRadius: BorderRadius.circular(50.r), // Apply .r for responsive border radius
                    onTap: () => controller.toggleFavorite(
                      product.id,
                    ), // Toggle favorite
                    child: Container(
                      padding: EdgeInsets.all(6.w), // Apply .w for responsive padding
                      height: 24.h, // Apply .h for responsive height
                      width: 24.w, // Apply .w for responsive width
                      decoration: BoxDecoration(
                        color:
                            controller.products
                                .firstWhere((p) => p.id == product.id)
                                .isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        colorFilter: ColorFilter.mode(
                          controller.products
                                  .firstWhere((p) => p.id == product.id)
                                  .isFavourite
                              ? const Color(0xFFFF4848)
                              : const Color(0xFFDBDEE4),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
