import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/strings.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/router/app_router.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import '../../../blocs/order/order_fetch/order_fetch_cubit.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/menu_item_card.dart';

class OtherView extends StatelessWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: vWPrimaryColor,
      child: SizedBox(
        width: size.width,
        height: size.height * 0.30,
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(flex: 8),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.80,
                  child: Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      if (state is UserLogged) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              AppRouter.userProfile,
                                              arguments: state.user,
                                            );
                                          },
                                          child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${state.user.firstName} ${state.user.lastName}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                  Text(state.user.email),
                                                ],
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed(AppRouter.signIn);
                                          },
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 36.0,
                                                backgroundImage: AssetImage(kUserAvatar),
                                                backgroundColor: Colors.transparent,
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Login in your account",
                                                    style: Theme.of(context).textTheme.titleLarge,
                                                  ),
                                                  const Text("")
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                // const SizedBox(height: 25),
                                const SizedBox(height: 30),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    return MenuItemCard(
                                      onClick: () {
                                        if (state is UserLogged) {
                                          Navigator.of(context).pushNamed(
                                            AppRouter.userProfile,
                                            arguments: state.user,
                                          );
                                        } else {
                                          Navigator.of(context)
                                              .pushNamed(AppRouter.signIn);
                                        }
                                      },
                                      title: "Profile",
                                    );
                                  },
                                ),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLogged) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: MenuItemCard(
                                          onClick: () {
                                            Navigator.of(context)
                                                .pushNamed(AppRouter.orders);
                                          },
                                          title: "Orders",
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLogged) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: MenuItemCard(
                                          onClick: () {
                                            Navigator.of(context).pushNamed(
                                                AppRouter.deliveryDetails);
                                          },
                                          title: "Delivery Info",
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                                const SizedBox(height: 6),
                                MenuItemCard(
                                  onClick: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouter.settings);
                                  },
                                  title: "Settings",
                                ),
                                const SizedBox(height: 6),
                                MenuItemCard(
                                  onClick: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouter.category);
                                  },
                                  title: "Category",
                                ),
                                const SizedBox(height: 6),
                                MenuItemCard(
                                  onClick: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouter.notifications);
                                  },
                                  title: "Notifications",
                                ),
                                const SizedBox(height: 6),
                                MenuItemCard(
                                  onClick: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouter.accountAndCardView);
                                  },
                                  title: "Account And Card",
                                ),
                                const SizedBox(height: 6),
                                MenuItemCard(
                                  onClick: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRouter.about);
                                  },
                                  title: "About",
                                ),
                                const SizedBox(height: 6),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLogged) {
                                      return MenuItemCard(
                                        onClick: () {
                                          context
                                              .read<UserBloc>()
                                              .add(SignOutUser());
                                          context
                                              .read<CartBloc>()
                                              .add(const ClearCart());
                                          context
                                              .read<DeliveryInfoFetchCubit>()
                                              .clearLocalDeliveryInfo();
                                          context
                                              .read<OrderFetchCubit>()
                                              .clearLocalOrders();
                                        },
                                        title: "Sign Out",
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).padding.bottom + 50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: const Alignment(0, -0.7),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Icon(
                      Icons.settings,
                      size: 110,
                      color: Colors.white,
                    ),
                  ),
                ),

              ),
            ),
            VwAppBar(title: "Setting", transparantMode: true,),
      ],
        ),
      ),
    );
  }
}
