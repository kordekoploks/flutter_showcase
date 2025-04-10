import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/router/app_router.dart';
import '../../../../../../l10n/gen_l10n/app_localizations.dart';

class ChangePassword2 extends StatelessWidget {
  const ChangePassword2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: AppLocalizations.of(context)!.changePassword),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset(cPsuccess),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.changePasswordSuccessfully,
                style: TextStyle(color: vWPrimaryColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.youHaveSuccessfullyChangePassword,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                AppLocalizations.of(context)!.pleaseUseTheNewPasswordWhenSignIn,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              VwButton(
                onClick: () {
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.passwordHasBeenChanged), // You can localize this string
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Wait a moment then navigate
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.signIn, // <- your sign-in route name
                          (route) => false,
                    );
                  });
                },
                titleText: AppLocalizations.of(context)!.changePassword,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
