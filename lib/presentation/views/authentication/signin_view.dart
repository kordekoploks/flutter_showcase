import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/blocs/home/navbar_cubit.dart';
import 'package:eshop/presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_button.dart';
import '../../widgets/input_text_form_field.dart';
import '../../widgets/vw_appbar.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController textinputcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is UserLoading) {
            EasyLoading.show(status: AppLocalizations.of(context)!.loading);
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
              EasyLoading.showError(AppLocalizations.of(context)!.thisFieldCantBeEmpty);
            } else {
              EasyLoading.showToast(AppLocalizations.of(context)!.error,toastPosition: EasyLoadingToastPosition.bottom, dismissOnTap: true);
            }
          }
        },
        child: Scaffold(
          backgroundColor: vWPrimaryColor,
          appBar: VwAppBar(title: AppLocalizations.of(context)!.signIn),
          body: Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView( // Changed Column to ListView for scrollable content
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: TextStyle(
                        color: vWPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0),
                    Text(
                      AppLocalizations.of(context)!.helloThereSignInToContinue,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    Center(child: Image.asset(kSignUp,height: 150,width: 150,)),
                    SizedBox(height: 25),
                    InputTextFormField(
                      controller: textinputcontroller,
                      hint: AppLocalizations.of(context)!.textInput,
                      prefixIcon: Icons.person_outlined,
                      textInputAction: TextInputAction.next,
                      isMandatory: true,
                    ),
                    SizedBox(height: 15),
                    InputTextFormField(
                      controller: passwordController,
                      hint: AppLocalizations.of(context)!.password,
                      isSecureField: true,
                      prefixIcon: Icons.lock_open_outlined,
                      textInputAction: TextInputAction.next,
                      isMandatory: true,
                    ),
                    SizedBox(height: 0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRouter.forgotPassword1);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgotYourPassword,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                      titleText: AppLocalizations.of(context)!.signIn,
                    ),
                    SizedBox(height: 30,),

                    Align( alignment: Alignment.center,
                      child: Text(AppLocalizations.of(context)!.orSignInWithSocialNetwork),
                    ),
                    SizedBox(height: 20,),
                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(kGoogle),
                        SizedBox(width: 15,),
                        Image.asset(kFacebook)
                      ],
                    ),SizedBox(height: 5,),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppLocalizations.of(context)!.dontHaveAnAccount),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRouter.signUp);
                            },
                            child: Text(AppLocalizations.of(context)!.signUP,style: TextStyle(color: vWPrimaryColor),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )

);
}
}
