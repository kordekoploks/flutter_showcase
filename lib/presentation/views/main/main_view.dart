import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../blocs/home/navbar_cubit.dart';
import '../../blocs/user/user_bloc.dart';
import '../authentication/signin_view.dart';
import 'home/home_view.dart';
import 'other/profile/profile_pengguna.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static const List<String> pageNames = ['HomeView', 'SignInView'];

  @override
  void initState() {
    super.initState();
    analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<NavbarCubit, int>(
            builder: (context, navbarState) {
              return AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    return PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: context.read<NavbarCubit>().controller,
                      children: <Widget>[
                        const HomeView(),
                        userState is UserLogged
                            ? const ProfilePengguna()
                            : const SignInView(),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 18,
            right: 18,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BlocBuilder<NavbarCubit, int>(
                builder: (context, state) {
                  return SnakeNavigationBar.color(
                    behaviour: SnakeBarBehaviour.floating,
                    snakeShape: SnakeShape.indicator,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                    ),
                    backgroundColor: Colors.black87,
                    snakeViewColor: Colors.black87,
                    height: 68,
                    elevation: 4,
                    selectedItemColor: SnakeShape.circle == SnakeShape.indicator
                        ? Colors.black87
                        : null,
                    unselectedItemColor: Colors.white,
                    selectedLabelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                    showUnselectedLabels: false,
                    showSelectedLabels: true,
                    currentIndex: state,
                    onTap: (index) async {
                      await analytics.logEvent(
                        name: 'pages_tracked',
                        parameters: {
                          "page_name": pageNames[index],
                          "page_index": index,
                        },
                      );
                      context.read<NavbarCubit>().controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                      context.read<NavbarCubit>().update(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/navbar_icons/home.png"),
                          color: Colors.white,
                          size: 26,
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            maxRadius: 4,
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage("assets/navbar_icons/user.png"),
                          color: Colors.white,
                          size: 26,
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            maxRadius: 4,
                          ),
                        ),
                        label: 'Other',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
