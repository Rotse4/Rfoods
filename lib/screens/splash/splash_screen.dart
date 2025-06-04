import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../../utils/constants.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/splash_content.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  final RxInt currentPage = 0.obs; // Reactive page index
  final List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Rfoofs, Let’s shop!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text": "We help people conect with store \naround Kenya",
      "image": "assets/images/splash_2.png",
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png",
    },
  ];

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) => currentPage.value = value,
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => AnimatedContainer(
                              duration: kAnimationDuration,
                              margin: const EdgeInsets.only(right: 5),
                              height: 6,
                              width: currentPage.value == index ? 20 : 6,
                              decoration: BoxDecoration(
                                color: currentPage.value == index
                                    ? kPrimaryColor
                                    : const Color(0xFFD8D8D8),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(SignInScreen.routeName); // Use GetX
                        },
                        child: const Text("Continue"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
