import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../utils/constants.dart';
import '../../otp/otp_screen.dart';
import '../../../controllers/auth_controller.dart';

class CompleteProfileForm extends StatelessWidget {
  const CompleteProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final errors = <String>[].obs;
    final address = ''.obs;
    Get.find<AuthController>();

    void addError(String error) {
      if (!errors.contains(error)) errors.add(error);
    }

    void removeError(String error) {
      errors.remove(error);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) => address.value = newValue ?? '',
            onChanged: (value) {
              if (value.isNotEmpty) removeError(kAddressNullError);
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(kAddressNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Address",
              hintText: "Enter your address",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(
                svgIcon: "assets/icons/Location point.svg",
              ),
            ),
          ),
          Obx(() => FormError(errors: errors)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Store address separately or skip if not needed
                Get.toNamed(OtpScreen.routeName);
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
