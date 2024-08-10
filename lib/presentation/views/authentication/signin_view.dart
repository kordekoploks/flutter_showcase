import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/blocs/home/navbar_cubit.dart';
import 'package:eshop/presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
          context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();
          context.read<OrderFetchCubit>().getOrders();
          context.read<NavbarCubit>().update(0);
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
              padding: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.03),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
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
                              child: Text(
                                "Forgot your credentials?",
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black54),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.87,
                      child: Stack(children: [
                        Column(
                          children: [
                            const Spacer(flex: 8),
                            SizedBox(
                              width: size.width,
                              height: size.height * 0.7,
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(size.width * 0.04),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: size.height * 0.07),
                                      SizedBox(height: size.height * 0.03),
                                      Text(
                                        "Let's Sign You In",
                                        style: Theme.of(context).textTheme.headline6,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Welcome back, you've been missed!",
                                        style: Theme.of(context).textTheme.subtitle1,
                                        textAlign: TextAlign.center,
                                      ),
                                      Spacer(),
                                      InputTextFormField(
                                        label: "Email",
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
                                      SizedBox(height: size.height * 0.02),
                                      InputTextFormField(
                                        label: "Password",
                                        prefixIcon: Icons.lock_outline,
                                        controller: passwordController,
                                        textInputAction: TextInputAction.go,
                                        isSecureField: true,
                                        validation: (String? val) {
                                          if (val == null || val.isEmpty) {
                                            return 'This field can\'t be empty';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (_) {
                                          if (_formKey.currentState!.validate()) {
                                            context
                                                .read<UserBloc>()
                                                .add(SignInUser(SignInParams(
                                              username: emailController.text,
                                              password: passwordController.text,
                                            )));
                                          }
                                        },
                                      ),
                                      SizedBox(height: size.height * 0.015),
                                      SizedBox(height: size.height * 0.03),
                                      VwButton(
                                        onClick: () {
                                          if (_formKey.currentState!.validate()) {
                                            context
                                                .read<UserBloc>()
                                                .add(SignInUser(SignInParams(
                                              username: emailController.text,
                                              password: passwordController.text,
                                            )));
                                          }
                                        },
                                        titleText: 'Sign In',
                                      ),
                                      SizedBox(height: size.height * 0.015),
                                      VwButton(
                                        onClick: () {
                                          Navigator.pushNamed(context, AppRouter.signUp);
                                        },
                                        titleText: 'Create an Account',
                                        buttonType: ButtonType.secondary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment(0, -0.99),
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.4,
                            child: SizedBox(
                              height: 80,
                              child: Image.asset(kThumb),
                            ),
                          ),
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
