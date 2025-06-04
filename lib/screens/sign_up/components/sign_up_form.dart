import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/form_error.dart';
import '../../../utils/constants.dart';
import '../../complete_profile/complete_profile_screen.dart';
import '../../../controllers/auth_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final errors = <String>[].obs;
    final fullName = ''.obs;
    final phoneNumber = ''.obs;
    final email = ''.obs;
    final password = ''.obs;
    final confirmPassword = ''.obs;
    final obscurePassword = true.obs;
    final obscureConfirmPassword = true.obs;
    final AuthController authController = Get.find<AuthController>();

    void addError(String error) {
      if (!errors.contains(error)) errors.add(error);
    }

    void removeError(String error) {
      errors.remove(error);
    }

    Widget buildTextField({
      required String hintText,
      required IconData prefixIcon,
      Widget? suffixIcon,
      TextInputType? keyboardType,
      bool obscureText = false,
      required Function(String?) onSaved,
      required Function(String) onChanged,
      required String? Function(String?) validator,
    }) {
      return Container(
        margin: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4.r,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: TextFormField(
          style: TextStyle(fontSize: 13.sp),
          keyboardType: keyboardType,
          obscureText: obscureText,
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: kTextColor.withOpacity(0.5),
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.all(6.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Icon(prefixIcon, color: kPrimaryColor, size: 16.sp),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: kSecondaryColor.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: kPrimaryColor, width: 1.5.w),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTextField(
            hintText: "Full Name",
            prefixIcon: Icons.person_outline,
            onSaved: (newValue) => fullName.value = newValue ?? '',
            onChanged: (value) {
              if (value.isNotEmpty) removeError(kNamelNullError);
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(kNamelNullError);
                return kNamelNullError;
              }
              return null;
            },
          ),

          buildTextField(
            hintText: "Phone Number",
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phoneNumber.value = newValue ?? '',
            onChanged: (value) {
              if (value.isNotEmpty) removeError(kPhoneNumberNullError);
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(kPhoneNumberNullError);
                return kPhoneNumberNullError;
              }
              if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                addError("Please enter a valid phone number");
                return kPhoneNumberInvalidError;
              }
              return null;
            },
          ),

          buildTextField(
            hintText: "Email Address",
            prefixIcon: Icons.email_outlined,
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
          ),

          Obx(
            () => buildTextField(
              hintText: "Password",
              prefixIcon: Icons.lock_outline,
              obscureText: obscurePassword.value,
              suffixIcon: GestureDetector(
                onTap: () => obscurePassword.value = !obscurePassword.value,
                child: Container(
                  margin: EdgeInsets.all(6.w),
                  child: Icon(
                    obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: kTextColor.withOpacity(0.6),
                    size: 18.sp,
                  ),
                ),
              ),
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
            ),
          ),

          Obx(
            () => buildTextField(
              hintText: "Confirm Password",
              prefixIcon: Icons.lock_outline,
              obscureText: obscureConfirmPassword.value,
              suffixIcon: GestureDetector(
                onTap: () => obscureConfirmPassword.value =
                    !obscureConfirmPassword.value,
                child: Container(
                  margin: EdgeInsets.all(6.w),
                  child: Icon(
                    obscureConfirmPassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: kTextColor.withOpacity(0.6),
                    size: 18.sp,
                  ),
                ),
              ),
              onSaved: (newValue) => confirmPassword.value = newValue ?? '',
              onChanged: (value) {
                if (value.isNotEmpty) removeError(kPassNullError);
                if (value == password.value) removeError(kMatchPassError);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(kPassNullError);
                  return kPassNullError;
                }
                if (value != password.value) {
                  addError(kMatchPassError);
                  return kMatchPassError;
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 2.h),
          Obx(() {
            final errorList = errors.toList();
            return errorList.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    // child: FormError(errors: errorList),
                  )
                : SizedBox.shrink();
          }),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 42.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.3),
                  blurRadius: 8.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  authController.signUp(
                    email.value,
                    password.value,
                    fullName.value,
                    phoneNumber.value,
                  );
                  Get.toNamed(CompleteProfileScreen.routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
