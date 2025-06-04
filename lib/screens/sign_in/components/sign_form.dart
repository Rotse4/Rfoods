import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../utils/constants.dart';
import '../../../helper/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../../controllers/auth_controller.dart';

class SignForm extends StatelessWidget {
  const SignForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final errors = <String>[].obs;
    final email = ''.obs;
    final password = ''.obs;
    final remember = false.obs;
    final obscurePassword = true.obs;
    final AuthController authController = Get.find<AuthController>();

    void addError(String error) {
      if (!errors.contains(error)) errors.add(error);
    }

    void removeError(String error) {
      errors.remove(error);
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email.value = newValue ?? '',
              onChanged: (value) {
                if (value.isNotEmpty) removeError(kEmailNullError);
                if (emailValidatorRegExp.hasMatch(value))
                  removeError(kInvalidEmailError);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(kEmailNullError);
                  return kEmailNullError;
                }
                if (!emailValidatorRegExp.hasMatch(value)) {
                  addError(kInvalidEmailError);
                  return kInvalidEmailError;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(
                  color: kTextColor.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                prefixIcon: Container(
                  margin: EdgeInsets.all(12.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.email_outlined,
                    color: kPrimaryColor,
                    size: 20.sp,
                  ),
                ),
                suffixIcon: const CustomSurffixIcon(
                  svgIcon: "assets/icons/Mail.svg",
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: kSecondaryColor.withOpacity(0.2),
                    width: 1.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Obx(
              () => TextFormField(
                obscureText: obscurePassword.value,
                onSaved: (newValue) => password.value = newValue ?? '',
                onChanged: (value) {
                  if (value.isNotEmpty) removeError(kPassNullError);
                  if (value.length >= 8) removeError(kShortPassError);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(kPassNullError);
                    return kPassNullError;
                  }
                  if (value.length < 8) {
                    addError(kShortPassError);
                    return kShortPassError;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: TextStyle(
                    color: kTextColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                  prefixIcon: Container(
                    margin: EdgeInsets.all(12.w),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      color: kPrimaryColor,
                      size: 20.sp,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => obscurePassword.value = !obscurePassword.value,
                    child: Container(
                      margin: EdgeInsets.all(12.w),
                      child: Icon(
                        obscurePassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: kTextColor.withOpacity(0.6),
                        size: 22.sp,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: kSecondaryColor.withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(color: kPrimaryColor, width: 2.w),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
Obx(
  () => Checkbox(
    value: remember.value,
    activeColor: kPrimaryColor,
    onChanged: (value) => remember.value = value ?? false,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),
),

              SizedBox(width: 8.w),
              Text(
                "Remember me",
                style: TextStyle(
                  color: kTextColor.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed(ForgotPasswordScreen.routeName),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          FormError(errors: errors),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.3),
                  blurRadius: 12.r,
                  offset: Offset(0, 6.h),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  authController.signIn(
                    email.value,
                    password.value,
                    remember.value,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
