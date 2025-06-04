import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rfoofs/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/product_controller.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

void main() {
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rfoofs',
          theme: AppTheme.lightTheme(context),
          initialRoute: SplashScreen.routeName,
          getPages: routes,
        );
      },
    );
  }
}
