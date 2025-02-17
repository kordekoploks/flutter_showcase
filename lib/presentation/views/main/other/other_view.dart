import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eshop/core/router/app_router.dart';
import 'package:eshop/presentation/blocs/cart/cart_bloc.dart';
import 'package:eshop/presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:eshop/presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'package:eshop/presentation/blocs/user/user_bloc.dart';
import 'package:eshop/presentation/widgets/menu_item_card.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_tab_bar.dart';

class OtherView extends StatefulWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OverlayMenuDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _OverlayMenuDelegate({required this.child});

  @override
  double get minExtent => 80; // Adjust as needed
  @override
  double get maxExtent => 80; // Adjust as needed

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none, // Allows overlap
      children: [
        Positioned(
          top: -40, // Moves it above SliverAppBar
          left: 0,
          right: 0,
          child: Material(
            elevation: 6, // Ensures it appears above SliverAppBar
            borderRadius: BorderRadius.circular(8),
            color: Colors.white, // Ensure visibility
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant _OverlayMenuDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

class _OtherViewState extends State<OtherView> {
  final List<String> _titles = ['', ''];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VwAppBar(title: "Settings"),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // SliverAppBar remains in place
            _buildSliverAppBar(),

            // Overlays menu positioned above SliverAppBar
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: _OverlayMenuDelegate(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildOverlaysMenuItems(),
                ),
              ),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: _buildMenuItems(),
          ),
        ),
      ),
    );
  }



  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade50,
      automaticallyImplyLeading: true,
      expandedHeight: 280.0,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: VwTabBar(
            titles: _titles,
            selectedIndex: _selectedIndex,
            onTabTapped: (index) => setState(() => _selectedIndex = index),
          ),
        ),
        background: Stack(
          children: [
            Image.asset(
              'assets/images/account_bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLogged) {
                    return FittedBox(
                      child: Text(
                        "${state.user.firstName[0].toUpperCase()}${state.user.lastName[0].toUpperCase()}",
                        style: const TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Main",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        ),
        SizedBox(height: 5,),
        _buildMenuCard([
          _buildUserDependentMenuItem("Profile", AppRouter.userProfile, AppRouter.signIn),
          _buildConditionalMenuItem("Orders", AppRouter.orders),
          _buildConditionalMenuItem("Delivery Info", AppRouter.deliveryDetails),
        ]),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Setting",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        ),
        SizedBox(height: 5,),
        _buildMenuCard([
          _buildMenuItem("Account And Card", AppRouter.accountAndCardView),
          _buildMenuItem("Settings", AppRouter.settings),
        ]),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        ),
        SizedBox(height: 5,),
        _buildMenuCard([
          _buildMenuItem("Category", AppRouter.category),
          _buildMenuItem("Income Category", AppRouter.incomeCategoryView),
        ]),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Other",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        ),
        SizedBox(height: 5,),
        _buildMenuCard([
          _buildMenuItem("Notifications", AppRouter.notifications),
          _buildMenuItem("About", AppRouter.about),
          _buildMenuItem("Help", AppRouter.helpView),
          _buildSignOutButton(),
        ]),
      ],
    );
  }

  Widget _buildOverlaysMenuItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuCard([
          _buildUserDependentMenuItem("Profile", AppRouter.userProfile, AppRouter.signIn),
          _buildConditionalMenuItem("Orders", AppRouter.orders),
          _buildConditionalMenuItem("Delivery Info", AppRouter.deliveryDetails),
        ]
        ),
      ],
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  Widget _buildMenuItem(String title, String route) {
    return MenuItemCard(
      onClick: () => Navigator.of(context).pushNamed(route),
      title: title,
    );
  }

  Widget _buildUserDependentMenuItem(String title, String loggedInRoute, String loggedOutRoute) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return MenuItemCard(
          onClick: () => Navigator.of(context).pushNamed(
            state is UserLogged ? loggedInRoute : loggedOutRoute,
            arguments: state is UserLogged ? state.user : null,
          ),
          title: title,
        );
      },
    );
  }

  Widget _buildConditionalMenuItem(String title, String route) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLogged) {
          return _buildMenuItem(title, route);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildSignOutButton() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLogged) {
          return MenuItemCard(
            onClick: () {
              context.read<UserBloc>().add(SignOutUser());
              context.read<CartBloc>().add(const ClearCart());
              context.read<DeliveryInfoFetchCubit>().clearLocalDeliveryInfo();
              context.read<OrderFetchCubit>().clearLocalOrders();
            },
            title: "Sign Out",
          );
        }
        return const SizedBox();
      },
    );
  }
}