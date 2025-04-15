import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/presentation/widgets/input_text_form_field.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:eshop/l10n/gen_l10n/app_localizations.dart';

import '../../../domain/usecases/user/sign_in_usecase.dart';
import '../../blocs/user/user_controller.dart';

class SignInViewGetX extends StatelessWidget {
  SignInViewGetX({Key? key}) : super(key: key);

  final userController = Get.find<UserController>(); // or Get.put(...) if not already initialized
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;


    ever(userController.user, (user) {
      if (user != null) {
        EasyLoading.dismiss();

        Get.offAllNamed(AppRouter.home);
      }
    });

    ever(userController.failure, (fail) {
      if (fail != null) {
        EasyLoading.dismiss();
        final msg = fail is CredentialFailure
            ? local.thisFieldCantBeEmpty
            : local.error;

        EasyLoading.showToast(
          msg,
          toastPosition: EasyLoadingToastPosition.bottom,
          dismissOnTap: true,
        );
      }
    });

    ever(userController.isLoading, (loading) {
      if (loading) {
        EasyLoading.show(status: local.loading);
      } else {
        EasyLoading.dismiss();
      }
    });

    return Scaffold(
      backgroundColor: vWPrimaryColor,
      appBar: VwAppBar(title: local.signIn),
      body: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Text(
                  local.welcomeBack,
                  style: TextStyle(
                    color: vWPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  local.helloThereSignInToContinue,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Center(child: Image.asset(kSignUp, height: 150, width: 150)),
                const SizedBox(height: 30),
                InputTextFormField(
                  controller: emailController,
                  hint: local.textInput,
                  prefixIcon: Icons.person_outlined,
                  textInputAction: TextInputAction.next,
                  isMandatory: true,
                ),
                const SizedBox(height: 15),
                InputTextFormField(
                  controller: passwordController,
                  hint: local.password,
                  isSecureField: true,
                  prefixIcon: Icons.lock_open_outlined,
                  textInputAction: TextInputAction.done,
                  isMandatory: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Get.toNamed(AppRouter.forgotPassword1),
                    child: Text(
                      local.forgotYourPassword,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                VwButton(
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      userController.signIn(
                        SignInParams(
                          username: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                  titleText: local.signIn,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    local.orSignInWithSocialNetwork,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(kGoogle, height: 46, width: 46),
                    const SizedBox(width: 16),
                    Image.asset(kFacebook, height: 46, width: 46),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        local.dontHaveAnAccount,
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () =>
                            Get.toNamed(AppRouter.signUp),
                        child: Text(
                          local.signUP,
                          style: TextStyle(
                              color: vWPrimaryColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
