import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil
import '../../controllers/cart_controller.dart'; // Import CartController
import 'components/cart_card.dart';
import 'components/check_out_card.dart';
import '../../models/Product.dart';
import '../../utils/currency_formatter.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
        Get.find<CartController>(); // Access CartController

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Column(
            children: [
              const Text("Your Cart", style: TextStyle(color: Colors.black)),
              Text(
                "${cartController.cartItems.length} items",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text("Your cart is empty"),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              final entry = cartController.cartItems.entries.elementAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Dismissible(
                  key: Key(entry.key.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    cartController.removeFromCart(entry.key);
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete,
                      color: Color(0xFFFF4848),
                    ),
                  ),
                  child: CartCard(
                    product: entry.key,
                    quantity: entry.value,
                  ),
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: cartController.getFormattedTotal(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 190.w,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement checkout
                        },
                        child: const Text("Check Out"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
