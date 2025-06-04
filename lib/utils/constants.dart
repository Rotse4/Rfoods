import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kSecondaryColor = Color(
  0xFF979797,
); // Neutral gray for secondary elements
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250); // For animations

final TextStyle headingStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final RegExp emailValidatorRegExp = RegExp(
  r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter a valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password must be at least 8 characters";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please enter your full name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";
const String kPhoneNumberInvalidError = "Please enter a valid phone number";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kPrimaryColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kPrimaryColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kPrimaryColor),
  ),
);
