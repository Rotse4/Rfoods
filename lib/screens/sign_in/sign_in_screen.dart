import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rfoofs/components/no_account_text.dart';
import '../../components/socal_card.dart';
import '../../utils/constants.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add this to prevent resizing when keyboard appears
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kPrimaryColor.withOpacity(0.05),
              Colors.white,
              kPrimaryColor.withOpacity(0.03),
            ],
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              // Add padding for keyboard
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).viewInsets.bottom,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      // Logo/Icon Section
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColor.withOpacity(0.2),
                              blurRadius: 15.r,
                              offset: Offset(0, 8.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.lock_person_rounded,
                          size: 30.sp,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Welcome Text
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Sign in to continue your journey",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: kTextColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // Form Section - Flexible container
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20.r,
                                offset: Offset(0, 5.h),
                              ),
                            ],
                          ),
                          child: const SignForm(),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.h,
                              color: kSecondaryColor.withOpacity(0.3),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              "Or",
                              style: TextStyle(
                                color: kTextColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1.h,
                              color: kSecondaryColor.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Social Login Cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 56.w,
                            height: 56.w,
                            margin: EdgeInsets.only(right: 6.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 6.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: SocalCard(
                              icon: "assets/icons/google-icon.svg",
                              press: () {},
                            ),
                          ),
                          Container(
                            width: 56.w,
                            height: 56.w,
                            margin: EdgeInsets.only(left: 6.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 6.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: SocalCard(
                              icon: "assets/icons/facebook-2.svg",
                              press: () {},
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),
                      const NoAccountText(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
