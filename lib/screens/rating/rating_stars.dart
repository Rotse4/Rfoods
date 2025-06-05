import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool allowHalfRating;

  const RatingStars({
    Key? key,
    required this.rating,
    this.size = 16,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.allowHalfRating = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double fillAmount = (rating - index).clamp(0.0, 1.0);
        
        return Icon(
          fillAmount >= 1.0
              ? Icons.star
              : (fillAmount >= 0.5 && allowHalfRating)
                  ? Icons.star_half
                  : Icons.star_border,
          size: size,
          color: fillAmount > 0 ? activeColor : inactiveColor,
        );
      }),
    );
  }
}
