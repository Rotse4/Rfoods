import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil
import '../../../utils/constants.dart';
import '../../../controllers/cart_controller.dart'; // Import CartController

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0, // Keep as default for non-cart icons
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
        Get.find<CartController>(); // Access CartController

    return InkWell(
      borderRadius: BorderRadius.circular(100.r),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            height: 46.h,
            width: 46.w,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc),
          ),
          if (svgSrc == "assets/icons/Cart Icon.svg") // Only for cart icon
            Obx(
              () => cartController.getItemCount() != 0
                  ? Positioned(
                      top: -3.h,
                      right: 0.w,
                      child: Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4848),
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.5.w, color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            "${cartController.getItemCount()}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              height: 1,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          else if (numOfitem != 0) // For non-cart icons (e.g., notifications)
            Positioned(
              top: -3.h,
              right: 0.w,
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5.w, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
