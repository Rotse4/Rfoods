import 'package:get/get.dart';
import 'package:r4foods/screens/sign_up/sign_up_screen.dart';

import '../screens/cart/cart_screen.dart';
import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/details/details_screen.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/init_screen.dart';
import '../screens/login_success/login_success_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';

import '../screens/splash/splash_screen.dart';

final List<GetPage> routes = [
  GetPage(name: InitScreen.routeName, page: () => InitScreen()),
  GetPage(name: SplashScreen.routeName, page: () => SplashScreen()),
  GetPage(name: SignInScreen.routeName, page: () => const SignInScreen()),
  GetPage(
    name: ForgotPasswordScreen.routeName,
    page: () => const ForgotPasswordScreen(),
  ),
  GetPage(
    name: LoginSuccessScreen.routeName,
    page: () => const LoginSuccessScreen(),
  ),
  GetPage(name: SignUpScreen.routeName, page: () => const SignUpScreen()),
  GetPage(
    name: CompleteProfileScreen.routeName,
    page: () => const CompleteProfileScreen(),
  ),
  GetPage(name: OtpScreen.routeName, page: () => const OtpScreen()),
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
  GetPage(name: ProductsScreen.routeName, page: () => const ProductsScreen()),
  GetPage(name: DetailsScreen.routeName, page: () => const DetailsScreen()),
  GetPage(name: CartScreen.routeName, page: () => const CartScreen()),
  GetPage(name: ProfileScreen.routeName, page: () => const ProfileScreen()),
];
