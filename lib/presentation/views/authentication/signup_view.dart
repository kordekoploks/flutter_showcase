import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
          EasyLoading.show(status: 'Loading...');
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          EasyLoading.showError("Error");
        }
      },
      child: Scaffold(
        appBar: VwAppBar(title: "Sign Up"),
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
                          "Welcome Back",
                          style: TextStyle(
                            color: vWPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 0),
                        Text(
                          "Hello There, Create New Account",
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    Align(
                      alignment: Alignment.center,
                      child: Text("Sign In With Social Networks"),
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
                      child: Text("Or Sign Up With Email"),
                    ),
                    SizedBox(height: 30),
                    InputTextFormField(
                      controller: firstNameController,
                      hint: "First Name",
                      prefixIcon: Icons.person_outlined,
                      textInputAction: TextInputAction.next,
                      isMandatory: true,
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: lastNameController,
                      prefixIcon: Icons.person_outlined,
                      hint: 'Last Name',
                      textInputAction: TextInputAction.next,
                      isMandatory: true,
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: phoneNumberController,
                      prefixIcon: Icons.phone_android_outlined,
                      hint: 'Phone Number',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(val)) {
                          return 'Enter a valid phone number';
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
                          return 'This field can\'t be empty';
                        }
                        if (!val.contains("@") || !val.contains('.')) {
                          return 'Enter a valid Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: passwordController,
                      hint: 'Password',
                      prefixIcon: Icons.lock_outline,
                      textInputAction: TextInputAction.next,
                      isSecureField: true,
                      isMandatory: true,
                    ),
                    SizedBox(height: 20),
                    InputTextFormField(
                      controller: confirmPasswordController,
                      hint: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      isSecureField: true,
                      textInputAction: TextInputAction.done,
                      isMandatory: true,
                      validation: (String? val) {
                        if (val != passwordController.text) {
                          return 'Passwords do not match';
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
                                "By creating an account, you agree to our",
                                style: TextStyle(fontSize: 12),
                              ),
                              VwTextLink(text: "Terms and Conditions."),
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
                      titleText: 'Sign Up',
                      buttonType: ButtonType.primary,
                    ),
                    SizedBox(height: 10),

                    Align(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRouter.signIn);
                            },
                            child: Text("Sign In",style: TextStyle(color: vWPrimaryColor)),
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
