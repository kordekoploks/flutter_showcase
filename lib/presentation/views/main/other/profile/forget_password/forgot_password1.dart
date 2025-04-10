import 'package:flutter/material.dart';
import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/l10n/gen_l10n/app_localizations.dart';

class ForgotPassword1 extends StatelessWidget {
  const ForgotPassword1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(
        title: AppLocalizations.of(context)!.forgotPassword,
      ),
      body: Center(
        child: Container(
          height: 330,
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
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.typeYourPhoneNumber,
                    style: const TextStyle(color: Colors.black26, fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "(+62)",
                      hintStyle: const TextStyle(color: Colors.black26),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.weTextedYouACodeToVerifyYourPhoneNumber,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  VwButton(
                    onClick: () {
                      Navigator.of(context).pushNamed(AppRouter.forgotPassword2);
                    },
                    titleText: AppLocalizations.of(context)!.send,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
