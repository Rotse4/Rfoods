import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteractiveRating extends StatefulWidget {
  final Function(double) onRatingChanged;
  final double initialRating;
  final double size;

  const InteractiveRating({
    Key? key,
    required this.onRatingChanged,
    this.initialRating = 0,
    this.size = 32.sp,
  }) : super(key: key);

  @override
  State<InteractiveRating> createState() => _InteractiveRatingState();
}

class _InteractiveRatingState extends State<InteractiveRating> {
  late double currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentRating = (index + 1).toDouble();
            });
            widget.onRatingChanged(currentRating);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Icon(
              index < currentRating ? Icons.star : Icons.star_border,
              size: widget.size,
              color: index < currentRating ? Colors.amber : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}