import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../blocs/cart/cart_bloc.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: AppLocalizations.of(context)!.loading);
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          EasyLoading.showError(AppLocalizations.of(context)!.error);
        }
      },
      child: Scaffold(
        appBar: VwAppBar(title: AppLocalizations.of(context)!.signUP),
        backgroundColor: vWPrimaryColor,
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcomeBack,
                          style: TextStyle(
                            color: vWPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 0),
                        Text(
                          AppLocalizations.of(context)!.helloThereCreateNewAccount,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    Align(
                      alignment: Alignment.center,
                      child: Text(AppLocalizations.of(context)!.signInWithSosialNetwork),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(kGoogle),
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(kFacebook)
                      ],
                    ),
                    SizedBox(height:45),
                    Align(
                      alignment: Alignment.center,
                      child: Text(AppLocalizations.of(context)!.orSignInWithEmail),
                    ),
                    SizedBox(height: 30),
                    InputTextFormField(
                      controller: firstNameController,
                      hint: AppLocalizations.of(context)!.firstName,
                      prefixIcon: Icons.person_outlined,
                      textInputAction: TextInputAction.next,
                      isMandatory: true,
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: lastNameController,
                      prefixIcon: Icons.person_outlined,
                      hint: AppLocalizations.of(context)!.lastName,
                      textInputAction: TextInputAction.next,
                      isMandatory: true,
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: phoneNumberController,
                      prefixIcon: Icons.phone_android_outlined,
                      hint: AppLocalizations.of(context)!.phoneNumber,
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!.thisFieldCantBeEmpty;
                        }
                        if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(val)) {
                          return AppLocalizations.of(context)!.enterAValidPhoneNumber;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      hint: "Email",
                      controller: emailController,
                      prefixIcon: Icons.email_outlined,
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return AppLocalizations.of(context)!.thisFieldCantBeEmpty;
                        }
                        if (!val.contains("@") || !val.contains('.')) {
                          return AppLocalizations.of(context)!.enterAValidPEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: passwordController,
                      hint: AppLocalizations.of(context)!.password,
                      prefixIcon: Icons.lock_outline,
                      textInputAction: TextInputAction.next,
                      isSecureField: true,
                      isMandatory: true,
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: confirmPasswordController,
                      hint: AppLocalizations.of(context)!.confirmPassword,
                      prefixIcon: Icons.lock_outline,
                      isSecureField: true,
                      textInputAction: TextInputAction.done,
                      isMandatory: true,
                      validation: (String? val) {
                        if (val != passwordController.text) {
                          return AppLocalizations.of(context)!.passwordDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VwCheckbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.byCreatingAnAccountYouAgreeToOur,
                                style: TextStyle(fontSize: 12),
                              ),
                              VwTextLink(text: AppLocalizations.of(context)!.termsAndCondition),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    VwButton(
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(SignUpUser(
                              SignUpParams(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phoneNumber:int.parse(phoneNumberController.text),
                                email: emailController.text,
                                password: passwordController.text,
                                //copy tapi ganti signup user jadi edit/update
                              )
                          )
                          );
                        }
                      },
                      titleText: AppLocalizations.of(context)!.signUP,
                      buttonType: ButtonType.primary,
                    ),
                    SizedBox(height: 10),

                    Align(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.alreadyHaveAnAccount),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRouter.signIn);
                            },
                            child: Text(AppLocalizations.of(context)!.signIn,style: TextStyle(color: vWPrimaryColor)),
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
      ),
    );
  }
}
