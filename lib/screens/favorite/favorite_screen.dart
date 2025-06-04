import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../components/product_card.dart';
import '../../controllers/product_controller.dart'; // Import ProductController
import '../details/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController =
        Get.find<ProductController>(); // Access ProductController

    return SafeArea(
      child: Column(
        children: [
          Text("Favorites", style: Theme.of(context).textTheme.titleLarge),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                final favoriteProducts = productController.products
                    .where((product) => product.isFavourite)
                    .toList();
                return favoriteProducts.isEmpty
                    ? const Center(child: Text("No favorite products"))
                    : GridView.builder(
                        itemCount: favoriteProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.6,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 16,
                            ),
                        itemBuilder: (context, index) => ProductCard(
                          product: favoriteProducts[index],
                          onPress: () => Get.toNamed(
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(
                              product: favoriteProducts[index],
                            ),
                          ), // Use GetX navigation
                        ),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
