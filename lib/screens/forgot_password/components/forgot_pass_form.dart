import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../utils/constants.dart';
import '../../init_screen.dart';
import '../../../controllers/auth_controller.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  // final errors = <String>[].obs; // RxList declared at state level
  final RxList<String> errors = <String>[].obs;

  // Helper methods to update errors reactively
  void addError(String error) {
    if (!errors.contains(error)) {
      errors.add(error);
    }
  }

  void removeError(String error) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(kInvalidEmailError);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                addError(kEmailNullError);
                return "";
              }
              if (!emailValidatorRegExp.hasMatch(value)) {
                addError(kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(color: kTextColor.withOpacity(0.5)),
              suffixIcon: const CustomSurffixIcon(
                svgIcon: "assets/icons/Mail.svg",
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: kSecondaryColor.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: kSecondaryColor.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kPrimaryColor),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // ignore: invalid_use_of_protected_member
          Obx(() => FormError(errors: errors.value)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final authController = Get.find<AuthController>();
                authController.forgotPassword(email.text);
                Get.toNamed(InitScreen.routeName);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 4,
              shadowColor: Colors.black26,
            ),
            child: const Text(
              "Send Reset Link",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
