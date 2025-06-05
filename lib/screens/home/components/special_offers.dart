import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import flutter_screenutil
import '../../products/products_screen.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w), // Apply .w for responsive horizontal padding
          child: SectionTitle(title: "Special for you", press: () {}),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Image Banner 2.png",
                category: "Smartphone",
                numOfBrands: 18,
                press: () {
                  Get.toNamed(ProductsScreen.routeName); // Use GetX navigation
                },
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 3.png",
                category: "Fashion",
                numOfBrands: 24,
                press: () {
                  Get.toNamed(ProductsScreen.routeName); // Use GetX navigation
                },
              ),
              SizedBox(width: 20.w), // Apply .w for responsive width
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w), // Apply .w for responsive left padding
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242.w, // Apply .w for responsive width
          height: 100.h, // Apply .h for responsive height
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r), // Apply .r for responsive border radius
            child: Stack(
              children: [
                Image.asset(image, fit: BoxFit.cover),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w, // Apply .w for responsive horizontal padding
                    vertical: 10.h, // Apply .h for responsive vertical padding
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: 18.sp, // Apply .sp for responsive font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
