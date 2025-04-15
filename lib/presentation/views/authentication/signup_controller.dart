import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../../core/router/app_router.dart';
import '../../blocs/user/user_controller.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var agreeToTerms = false.obs;

  void onSignUpPressed() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    final userController = Get.find<UserController>();

    try {
      final result = await userController.signUp(SignUpParams(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
        email: emailController.text.trim(),
        password: passwordController.text,
      ));

      isLoading.value = false;

      // If signUp throws on failure, this is fine
      Get.offAllNamed(AppRouter.home);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Sign Up Failed: ${e.toString()}");
    }
  }

}
