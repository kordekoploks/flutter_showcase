import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/widgets/input_text_form_field.dart';
import 'package:eshop/presentation/widgets/input_confirm_password.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../widgets/vw_appbar.dart';
import 'change_password2.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  //
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: VwAppBar(title: "Change Password"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 380,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InputTextFormField(
                        label: "Type your new password",
                        controller: passwordController,
                        textInputAction: TextInputAction.go,
                        isSecureField: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InputTextFormField(
                        label: "Confirm Password",
                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.go,
                        isSecureField: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                    SizedBox(height: 70),
                    VwButton(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(AppRouter.changePassword2);
                        },
                        titleText: "Change Password"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
