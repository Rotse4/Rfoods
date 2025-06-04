import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../../components/rounded_icon_btn.dart';
import '../../../utils/constants.dart';
import '../../../models/Product.dart';

class ColorDots extends StatelessWidget {
  ColorDots({Key? key, required this.product}) : super(key: key);

  final Product product;
  final RxInt selectedColor = 3.obs; // Reactive state for selected color

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            product.colors.length,
            (index) => Obx(
              () => ColorDot(
                // Use Obx for reactivity
                color: product.colors[index],
                isSelected: index == selectedColor.value,
                onTap: () =>
                    selectedColor.value = index, // Update selected color
              ),
            ),
          ),
          const Spacer(),
          RoundedIconBtn(icon: Icons.remove, press: () {}),
          const SizedBox(width: 20),
          RoundedIconBtn(icon: Icons.add, showShadow: true, press: () {}),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    required this.isSelected,
    this.onTap, // Add onTap callback
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(8),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.transparent,
          ),
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
