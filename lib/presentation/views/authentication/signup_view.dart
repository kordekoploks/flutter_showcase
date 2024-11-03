import 'dart:ffi';

import 'package:eshop/presentation/widgets/vw_text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_button.dart';
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
          EasyLoading.show(status: 'Loading...');
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          if (state.failure is CredentialFailure) {
            EasyLoading.showError("Username/Password Wrong!");
          } else {
            EasyLoading.showError("Error");
          }
        }
      },
      child: Scaffold(
        backgroundColor: vLightSecondaryColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, size.height * 0.05, 0, size.height * 0.03),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SizedBox(
                              height: size.height * 0.03,
                              child: Image.asset(
                                kClose,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black54,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                        color: Colors
                                            .amber, // Set your desired color here
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.90,
                      child: Stack(children: [
                        Column(
                          children: [
                            const Spacer(flex: 8),
                            SizedBox(
                              width: size.width,
                              height: size.height * 0.8,
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(size.width * 0.04),
                                  child: SingleChildScrollView(
                                    // Wrap the content with SingleChildScrollView
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(height: size.height * 0.02),
                                        Text(
                                          "Getting Started",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "Create an account to continue!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: size.height * 0.07),
                                        InputTextFormField(
                                          label: "First Name",
                                          controller: firstNameController,
                                          prefixIcon: Icons.person_outlined,
                                          textInputAction: TextInputAction.next,
                                          isMandatory: true,
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        InputTextFormField(
                                          controller: lastNameController,
                                          prefixIcon: Icons.person_outlined,
                                          isMandatory: false,
                                          label: 'Last Name',
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        InputTextFormField(
                                          controller: phoneNumberController,
                                          prefixIcon:
                                              Icons.phone_android_outlined,
                                          label: 'Phone Number',
                                          textInputAction: TextInputAction.next,
                                          isMandatory: false,
                                          validation: (String? val) {
                                            if (val == null || val.isEmpty) {
                                              return 'This field can\'t be empty';
                                            }
                                            final phoneRegExp = RegExp(
                                                r'^\+?[0-9]{10,15}$'); // Regex for phone number validation
                                            if (!phoneRegExp.hasMatch(val)) {
                                              return 'Enter a valid phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        InputTextFormField(
                                          label: "Email",
                                          controller: emailController,
                                          prefixIcon: Icons.email_outlined,
                                          textInputAction: TextInputAction.next,
                                          validation: (String? val) {
                                            if (val == null || val.isEmpty) {
                                              return 'This field can\'t be empty';
                                            }
                                            if (!val.contains("@") ||
                                                !val.contains('.')) {
                                              return 'Enter a valid Email';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        InputTextFormField(
                                          controller: passwordController,
                                          label: 'Password',
                                          prefixIcon: Icons.lock_outline,
                                          textInputAction: TextInputAction.next,
                                          isSecureField: true,
                                          isMandatory: true,
                                        ),
                                        SizedBox(height: 12),
                                        InputTextFormField(
                                          controller: confirmPasswordController,
                                          label: 'Confirm Password',
                                          prefixIcon: Icons.lock_outline,
                                          isSecureField: true,
                                          textInputAction: TextInputAction.go,
                                          isMandatory: true,
                                          onFieldSubmitted: (_) {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (passwordController.text !=
                                                  confirmPasswordController
                                                      .text) {
                                                return "Password missmatch";
                                              } else {
                                                context.read<UserBloc>().add(
                                                        SignUpUser(SignUpParams(
                                                      firstName:
                                                          firstNameController
                                                              .text,
                                                      lastName:
                                                          lastNameController
                                                              .text,
                                                      phoneNumber: int.parse(phoneNumberController.text),
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                    )));
                                              }
                                            }
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            VwCheckbox(
                                             value: false, onChanged: (bool? value) {  },
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "By createing an account, you aggree to our.",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                 VwTextLink(text:" Terms and Conditions."),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.015),
                                        VwButton(
                                          onClick: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (passwordController.text !=
                                                  confirmPasswordController
                                                      .text) {
                                                // Handle password mismatch««
                                              } else {
                                                context.read<UserBloc>().add(
                                                        SignUpUser(SignUpParams(
                                                      firstName:
                                                          firstNameController
                                                              .text,
                                                      lastName:
                                                          lastNameController
                                                              .text,
                                                      phoneNumber: int.parse(phoneNumberController.text),
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                    )));
                                              }
                                            }
                                          },
                                          titleText: 'Sign Up',
                                          buttonType: ButtonType.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
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
