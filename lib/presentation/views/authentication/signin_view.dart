import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/domain/usecases/user/sign_in_usecase.dart';
import 'package:eshop/l10n/gen_l10n/app_localizations.dart';
import 'package:eshop/presentation/blocs/home/navbar_cubit.dart';
import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:eshop/presentation/widgets/input_text_form_field.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleState(BuildContext context, UserState state) {
    EasyLoading.dismiss();

    if (state is UserLoading) {
      EasyLoading.show(status: AppLocalizations.of(context)!.loading);
    } else if (state is UserLogged) {
      context.read<NavbarCubit>().update(0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
    } else if (state is UserLoggedFail) {
      final message = state.failure is CredentialFailure
          ? AppLocalizations.of(context)!.thisFieldCantBeEmpty
          : AppLocalizations.of(context)!.error;

      EasyLoading.showToast(message,
          toastPosition: EasyLoadingToastPosition.bottom, dismissOnTap: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: _handleState,
      child: Scaffold(
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
                    AppLocalizations.of(context)!.welcomeBack,
                    style: TextStyle(
                      color: vWPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(AppLocalizations.of(context)!.helloThereSignInToContinue,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Center(child: Image.asset(kSignUp, height: 150, width: 150)),
                  const SizedBox(height: 30),
                  InputTextFormField(
                    controller: emailController,
                    hint: AppLocalizations.of(context)!.textInput,
                    prefixIcon: Icons.person_outlined,
                    textInputAction: TextInputAction.next,
                    isMandatory: true,
                  ),
                  const SizedBox(height: 15),
                  InputTextFormField(
                    controller: passwordController,
                    hint: AppLocalizations.of(context)!.password,
                    isSecureField: true,
                    prefixIcon: Icons.lock_open_outlined,
                    textInputAction: TextInputAction.done,
                    isMandatory: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRouter.forgotPassword1),
                      child: Text(
                          AppLocalizations.of(context)!.forgotYourPassword,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  VwButton(
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UserBloc>().add(SignInUser(
                              SignInParams(
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            ));
                      }
                    },
                    titleText: AppLocalizations.of(context)!.signIn,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.orSignInWithSocialNetwork,
                      style: TextStyle(fontSize: 16),
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
                          AppLocalizations.of(context)!.dontHaveAnAccount,
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed(AppRouter.signUp),
                          child: Text(AppLocalizations.of(context)!.signUP,
                              style: TextStyle(
                                  color: vWPrimaryColor, fontSize: 16)),
                        ),
                      ],
                    ),
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
