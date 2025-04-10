import 'package:flutter/material.dart';
import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/widgets/input_text_form_field.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/l10n/gen_l10n/app_localizations.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: AppLocalizations.of(context)!.changePassword),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTextFormField(
                        controller: passwordController,
                        hint: AppLocalizations.of(context)!.password,
                        isSecureField: true,
                        prefixIcon: Icons.lock_open_outlined,
                        textInputAction: TextInputAction.next,
                        isMandatory: true,
                      ),
                      const SizedBox(height: 24),
                      InputTextFormField(
                        controller: confirmPasswordController,
                        hint: AppLocalizations.of(context)!.confirmPassword,
                        isSecureField: true,
                        isMandatory: true,
                        prefixIcon: Icons.lock_open_outlined,
                        textInputAction: TextInputAction.done,
                        validation: (val) {
                          if (val == null || val.isEmpty) {
                            return AppLocalizations.of(context)!.thisFieldCantBeEmpty;
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {},
                      ),
                      const SizedBox(height: 70),
                      VwButton(
                        onClick: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.of(context).pushNamed(AppRouter.changePassword2);
                          }
                        },
                        titleText: AppLocalizations.of(context)!.changePassword,
                      ),
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
