import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants.dart';
import '../../../controllers/auth_controller.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final pin2FocusNode = FocusNode();
    final pin3FocusNode = FocusNode();
    final pin4FocusNode = FocusNode();

    void nextField(String value, FocusNode? focusNode) {
      if (value.length == 1) {
        focusNode?.requestFocus();
      }
    }

    return Form(
      child: Column(
        children: [
          SizedBox(height: 0.15.sh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60.w,
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24.sp),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    authController.setOtpDigit(0, value);
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60.w,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24.sp),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    authController.setOtpDigit(1, value);
                    nextField(value, pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60.w,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24.sp),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    authController.setOtpDigit(2, value);
                    nextField(value, pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60.w,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24.sp),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    authController.setOtpDigit(3, value);
                    if (value.length == 1) {
                      pin4FocusNode.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 0.15.sh),
          ElevatedButton(
            onPressed: () {
              final otpCode = authController.otp.join();
              authController.verifyOtp(otpCode);
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
