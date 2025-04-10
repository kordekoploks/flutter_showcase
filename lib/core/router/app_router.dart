import 'package:eshop/presentation/views/main/home/filter/filter_view.dart';
import 'package:eshop/presentation/views/main/other/profile/forget_password/change_password.dart';
import 'package:eshop/presentation/views/main/other/profile/forget_password/change_password2.dart';
import 'package:eshop/presentation/views/main/other/profile/forget_password/forgot_password1.dart';
import 'package:eshop/presentation/views/main/other/profile/forget_password/forgot_password2.dart';
import 'package:eshop/presentation/views/main/other/profile/profile_edit_view.dart';
import 'package:eshop/presentation/views/main/other/profile/profile_pengguna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product/product.dart';
import '../../domain/entities/user/user.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../../presentation/views/authentication/signin_view.dart';
import '../../presentation/views/authentication/signup_view.dart';
import '../../presentation/views/main/main_view.dart';
import '../../presentation/views/main/other/profile/profile_screen.dart';
import '../../presentation/views/product/product_details_view.dart';
import '../error/exceptions.dart';

class AppRouter {
  //main menu
  static const String home = '/';
  //authentication
  static const String signIn = '/sign-in';
  static const String forgotPassword1 = '/forgot-password1';
  static const String forgotPassword2 = '/forgot-password2';
  static const String changePassword = '/change-password';
  static const String changePassword2 = '/change-password2';
  static const String signUp = '/sign-up';
  static const String profilePengguna = '/profile-pengguna';
  static const String profileEditView = '/profile-edit-view';
  static const String incomeAdd = '/income-add';
  static const String accountAndCardView = '/account_card-and-card-view';
  static const String helpView = '/help-view';
  static const String incomeCategoryView = '/income-category-view';

  //products
  static const String productDetails = '/product-details';
  //other
  static const String userProfile = '/user-profile';
  static const String orderCheckout = '/order-checkout';
  static const String deliveryDetails = '/delivery-details';
  static const String orders = '/orders';
  static const String settings = '/settings';
  static const String category = '/category';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String filter = '/filter';


  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case signIn: {
        return MaterialPageRoute(
          builder: (context) {
            final userState = BlocProvider.of<UserBloc>(context).state;
            if (userState is UserLogged) {
              return const ProfilePengguna();
            } else {
              return const SignInView();
            }
          },
        );
      }

      case forgotPassword1:
        return MaterialPageRoute(builder: (_) => const ForgotPassword1());
      case forgotPassword2:
        return MaterialPageRoute(builder: (_) => const ForgotPassword2());
        case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case changePassword2:
        return MaterialPageRoute(builder: (_) => const ChangePassword2());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case profilePengguna:
        return MaterialPageRoute(builder: (_) => const ProfilePengguna());
      case productDetails:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsView(product: product));
      case userProfile:
        User user = routeSettings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => UserProfileScreen(
                  user: user,
                ));
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterView());
      case profileEditView:
        User user = routeSettings.arguments as User;
        return MaterialPageRoute(builder: (_) => ProfileEditView(
              user: user,));

      default:
        throw const RouteException('Route not found!');
    }
  }
}
