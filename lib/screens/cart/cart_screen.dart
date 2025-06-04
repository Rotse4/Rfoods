import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX
import '../../controllers/cart_controller.dart'; // Import CartController
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: cartController.cartItems.isEmpty
              ? const Center(child: Text("Your cart is empty"))
              : ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cartItems.keys.elementAt(
                      index,
                    );
                    final quantity = cartController.cartItems[product]!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(product.id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          cartController.removeFromCart(
                            product,
                          ); // Remove using controller
                        },
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(product: product, quantity: quantity),
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: const CheckoutCard(),
    );
  }
}
