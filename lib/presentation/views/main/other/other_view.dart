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
                                          child: Row(
                                            children: [
                                              state.user.image != null
                                                  ? CachedNetworkImage(
                                                      imageUrl: state.user.image!,
                                                      imageBuilder:
                                                          (context, image) =>
                                                              CircleAvatar(
                                                        radius: 36.0,
                                                        backgroundImage: image,
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    )
                                                  : const CircleAvatar(
                                                      radius: 36.0,
                                                      backgroundImage:
                                                          AssetImage(kUserAvatar),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                            children: [],
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
              alignment: const Alignment(0, -1.2),
              child: Container(
                width: size.width * 0.5,
                height: size.height * 0.5,
                child: SizedBox(
                  height: 80,
                  child: Image.asset(kThumb),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(4.7,-0.35),
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.2,
                child: SizedBox(
                  height: 80,
                  child: Text("Flying Dutchman",style: TextStyle(color: vWPrimaryColor,fontWeight: FontWeight.bold,fontSize: 18)),
                ),
              ),
            ),
             VwAppBar(title: "Setting"),
      ],
        ),
      ),
    );
  }
}
