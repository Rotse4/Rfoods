import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../components/product_card.dart';
import '../../models/Product.dart';
import '../details/details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            itemCount: demoProducts.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.6,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => ProductCard(
              product: demoProducts[index],
              onPress: () => Get.toNamed(
                DetailsScreen.routeName,
                arguments: ProductDetailsArguments(
                  product: demoProducts[index],
                ),
              ), // Use GetX navigation
            ),
          ),
        ),
      ),
    );
  }
}
