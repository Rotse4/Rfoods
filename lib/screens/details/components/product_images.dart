import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../../utils/constants.dart';
import '../../../models/Product.dart';

class ProductImages extends StatelessWidget {
  ProductImages({Key? key, required this.product}) : super(key: key);

  final Product product;
  final RxInt selectedImage = 0.obs; // Reactive state for selected image

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Obx(() => Image.asset(product.images[selectedImage.value])),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              product.images.length,
              (index) => SmallProductImage(
                isSelected: index == selectedImage.value,
                press: () {
                  selectedImage.value = index; // Update reactive state
                },
                image: product.images[index],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SmallProductImage extends StatelessWidget {
  const SmallProductImage({
    super.key,
    required this.isSelected,
    required this.press,
    required this.image,
  });

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kPrimaryColor.withOpacity(isSelected ? 1 : 0),
          ),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
