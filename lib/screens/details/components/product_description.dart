import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX
import '../../../utils/constants.dart';
import '../../../models/Product.dart';
import '../../../controllers/product_controller.dart'; // Import ProductController

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
        Get.find<ProductController>(); // Access controller

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(
            () => GestureDetector(
              // Wrap in Obx for reactivity
              onTap: () =>
                  controller.toggleFavorite(product.id), // Toggle favorite
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 48,
                decoration: BoxDecoration(
                  color:
                      controller.products
                          .firstWhere((p) => p.id == product.id)
                          .isFavourite
                      ? const Color(0xFFFFE6E6)
                      : const Color(0xFFF5F6F9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
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
                  height: 16,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 64),
          child: Text(product.description, maxLines: 3),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GestureDetector(
            onTap: pressOnSeeMore,
            child: const Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 12, color: kPrimaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
