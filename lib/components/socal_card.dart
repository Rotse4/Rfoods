import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({Key? key, this.icon, this.press}) : super(key: key);

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: SvgPicture.asset(icon!, height: 24, width: 24)),
      ),
    );
  }
}
