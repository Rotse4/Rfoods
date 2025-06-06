import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Get.toNamed(ProductsScreen.routeName); // Use GetX navigation
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(demoProducts.length, (index) {
                if (demoProducts[index].isPopular) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ProductCard(
                      product: demoProducts[index],
                      onPress: () => Get.toNamed(
                        DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(
                          product: demoProducts[index],
                        ),
                      ), // Use GetX navigation
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
