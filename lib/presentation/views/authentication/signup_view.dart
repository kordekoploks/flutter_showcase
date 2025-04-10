import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_text_form_field.dart';
import '../../widgets/vw_button.dart';
import '../../widgets/vw_checkbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: localization.loading);
        } else if (state is UserLogged) {
          Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
        } else if (state is UserLoggedFail) {
          EasyLoading.showError(localization.error);
        }
      },
      child: Scaffold(
        appBar: VwAppBar(title: localization.signUP),
        backgroundColor: vWPrimaryColor,
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(localization.welcomeBack,
                      style: TextStyle(
                        color: vWPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 4),
                  Text(localization.helloThereCreateNewAccount,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 40),
                  Text(localization.signInWithSosialNetwork),
                  const SizedBox(height: 35),
                  _buildSocialButtons(),
                  const SizedBox(height: 45),
                  Text(localization.orSignInWithEmail),
                  const SizedBox(height: 30),
                  _buildInputField(firstNameController, localization.firstName, Icons.person_outlined),
                  const SizedBox(height: 20),
                  _buildInputField(lastNameController, localization.lastName, Icons.person_outlined),
                  const SizedBox(height: 20),
                  _buildInputField(
                    phoneNumberController,
                    localization.phoneNumber,
                    Icons.phone_android_outlined,
                    validator: (val) => _validatePhoneNumber(val, context),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    emailController,
                    "Email",
                    Icons.email_outlined,
                    validator: (val) => _validateEmail(val, context),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    passwordController,
                    localization.password,
                    Icons.lock_outline,
                    isSecure: true,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    confirmPasswordController,
                    localization.confirmPassword,
                    Icons.lock_outline,
                    isSecure: true,
                    validator: (val) => _validateConfirmPassword(val, context),
                  ),
                  const SizedBox(height: 20),
                  _buildTermsAndConditions(context),
                  const SizedBox(height: 20),
                  VwButton(
                    onClick: _onSignUpPressed,
                    titleText: localization.signUP,
                    buttonType: ButtonType.primary,
                  ),
                  const SizedBox(height: 10),
                  _buildSignInRedirect(localization),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Widget _buildInputField(
      TextEditingController controller,
      String hint,
      IconData icon, {
        TextInputAction action = TextInputAction.next,
        bool isSecure = false,
        bool isMandatory = true,
        String? Function(String?)? validator,
      }) {
    return InputTextFormField(
      controller: controller,
      hint: hint,
      prefixIcon: icon,
      textInputAction: action,
      isSecureField: isSecure,
      isMandatory: isMandatory,
      validation: validator,
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VwCheckbox(
          value: _agreeToTerms,
          onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.byCreatingAnAccountYouAgreeToOur,
                style: const TextStyle(fontSize: 12),
              ),
              VwTextLink(text: localization.termsAndCondition),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignInRedirect(AppLocalizations localization) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(localization.alreadyHaveAnAccount),
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed(AppRouter.signIn),
          child: Text(localization.signIn, style: TextStyle(color: vWPrimaryColor)),
        ),
      ],
    );
  }

  void _onSignUpPressed() {

    if (_formKey.currentState?.validate() ?? false) {
      context.read<UserBloc>().add(SignUpUser(SignUpParams(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
        email: emailController.text.trim(),
        password: passwordController.text,
      )));
    }
  }

  String? _validateEmail(String? val, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) return loc.thisFieldCantBeEmpty;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(val)) return loc.enterAValidPEmail;
    return null;
  }

  String? _validatePhoneNumber(String? val, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (val == null || val.isEmpty) return loc.thisFieldCantBeEmpty;
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(val)) return loc.enterAValidPhoneNumber;
    return null;
  }

  String? _validateConfirmPassword(String? val, BuildContext context) {
    if (val != passwordController.text) {
      return AppLocalizations.of(context)!.passwordDoNotMatch;
    }
    return null;
  }
}
