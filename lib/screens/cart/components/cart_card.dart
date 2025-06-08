import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../../../utils/currency_formatter.dart';
import '../../../models/Product.dart';
import '../../../controllers/cart_controller.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Row(
      children: [
        SizedBox(
          width: 88.w,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Image.asset(product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      cartController.removeFromCart(product);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: CurrencyFormatter.formatKES(product.price * quantity),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            cartController.updateQuantity(product, quantity - 1);
                          } else {
                            cartController.removeFromCart(product);
                          }
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartController.updateQuantity(product, quantity + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
