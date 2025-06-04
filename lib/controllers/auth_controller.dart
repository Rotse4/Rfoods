import 'package:get/get.dart';
import '../screens/init_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var isSignedIn = false.obs;
  var otp = ['', '', '', ''].obs;

  void signIn(String email, String password, bool remember) {
    this.email.value = email;
    this.password.value = password;
    isSignedIn.value = true;
    Get.toNamed(InitScreen.routeName);
  }

  void signUp(
    String email,
    String password,
    String fullName,
    String phoneNumber,
  ) {
    this.email.value = email;
    this.password.value = password;
    this.fullName.value = fullName;
    this.phoneNumber.value = phoneNumber;
    // Simulate sign-up
    Get.snackbar('Success', 'Account created for $fullName');
  }

  void forgotPassword(String email) {
    this.email.value = email;
    Get.snackbar('Password Reset', 'Reset link sent to $email');
  }

  void setOtpDigit(int index, String value) {
    if (value.length <= 1) otp[index] = value;
  }

  void verifyOtp(String otpCode) {
    Get.toNamed(InitScreen.routeName); // Simulate OTP verification
  }

  void logout() {
    isSignedIn.value = false;
    email.value = '';
    password.value = '';
    fullName.value = '';
    phoneNumber.value = '';
    Get.toNamed(SignInScreen.routeName);
  }
}
