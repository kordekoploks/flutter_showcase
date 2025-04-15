import 'package:eshop/presentation/views/authentication/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images.dart';
import '../../../core/router/app_router.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';
import '../../widgets/input_text_form_field.dart';
import '../../widgets/vw_appbar.dart';
import '../../widgets/vw_button.dart';
import '../../widgets/vw_checkbox.dart';
import '../../widgets/vw_text_link.dart';

class SignUpViewGetX extends StatelessWidget {
  SignUpViewGetX({Key? key}) : super(key: key);
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Obx(() {
      if (controller.isLoading.value) EasyLoading.show(status: loc.loading);
      else EasyLoading.dismiss();

      return Scaffold(
        appBar: VwAppBar(title: loc.signUP),
        backgroundColor: vWPrimaryColor,
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(loc.welcomeBack, style: TextStyle(color: vWPrimaryColor, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(loc.helloThereCreateNewAccount, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 40),
                  Text(loc.signInWithSosialNetwork),
                  const SizedBox(height: 35),
                  _buildSocialButtons(),
                  const SizedBox(height: 45),
                  Text(loc.orSignInWithEmail),
                  const SizedBox(height: 30),
                  _buildInput(controller.firstNameController, loc.firstName, Icons.person_outlined),
                  const SizedBox(height: 20),
                  _buildInput(controller.lastNameController, loc.lastName, Icons.person_outlined),
                  const SizedBox(height: 20),
                  _buildInput(controller.phoneNumberController, loc.phoneNumber, Icons.phone_android_outlined,
                      validator: (val) => _validatePhone(val, context)),
                  const SizedBox(height: 20),
                  _buildInput(controller.emailController, "Email", Icons.email_outlined,
                      validator: (val) => _validateEmail(val, context)),
                  const SizedBox(height: 20),
                  _buildInput(controller.passwordController, loc.password, Icons.lock_outline, isSecure: true),
                  const SizedBox(height: 20),
                  _buildInput(controller.confirmPasswordController, loc.confirmPassword, Icons.lock_outline,
                      isSecure: true, validator: (val) => _validateConfirmPassword(val, context)),
                  const SizedBox(height: 20),
                  _buildTermsAndConditions(context),
                  const SizedBox(height: 20),
                  VwButton(
                    onClick: controller.onSignUpPressed,
                    titleText: loc.signUP,
                    buttonType: ButtonType.primary,
                  ),
                  const SizedBox(height: 10),
                  _buildSignInRedirect(loc),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInput(TextEditingController ctrl, String hint, IconData icon,
      {TextInputAction action = TextInputAction.next,
        bool isSecure = false,
        String? Function(String?)? validator}) {
    return InputTextFormField(
      controller: ctrl,
      hint: hint,
      prefixIcon: icon,
      textInputAction: action,
      isSecureField: isSecure,
      validation: validator,
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VwCheckbox(
          value: controller.agreeToTerms.value,
          onChanged: (val) => controller.agreeToTerms.value = val ?? false,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.byCreatingAnAccountYouAgreeToOur, style: const TextStyle(fontSize: 12)),
              VwTextLink(text: loc.termsAndCondition),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(image: AssetImage(kGoogle)),
        SizedBox(width: 15),
        Image(image: AssetImage(kFacebook)),
      ],
    );
  }

  Widget _buildSignInRedirect(AppLocalizations loc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(loc.alreadyHaveAnAccount),
        TextButton(
          onPressed: () => Get.toNamed(AppRouter.signIn),
          child: Text(loc.signIn, style: TextStyle(color: vWPrimaryColor)),
        ),
      ],
    );
  }

  String? _validateEmail(String? val, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) return loc.thisFieldCantBeEmpty;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(val)) return loc.enterAValidPEmail;
    return null;
  }

  String? _validatePhone(String? val, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) return loc.thisFieldCantBeEmpty;
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(val)) return loc.enterAValidPhoneNumber;
    return null;
  }

  String? _validateConfirmPassword(String? val, BuildContext context) {
    final controller = Get.find<SignUpController>();
    if (val != controller.passwordController.text) {
      return AppLocalizations.of(context)!.passwordDoNotMatch;
    }
    return null;
  }
}
