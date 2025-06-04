import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:r4foods/screens/favorite/favorite_screen.dart';
import 'package:r4foods/screens/home/home_screen.dart';
import 'package:r4foods/screens/profile/profile_screen.dart';


import '../utils/constants.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatelessWidget {
  static String routeName = "/";

  final RxInt currentSelectedIndex = 0.obs; // Reactive index
  final pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const Center(child: Text("Chat")),
    const ProfileScreen(),
  ];

  InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[currentSelectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) => currentSelectedIndex.value = index,
          currentIndex: currentSelectedIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Heart Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Heart Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Fav",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
