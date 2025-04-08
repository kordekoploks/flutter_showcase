import 'package:eshop/presentation/views/main/other/profile/profile_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/vw_appbar.dart';

class ProfilePengguna extends StatelessWidget {
  const ProfilePengguna({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VwAppBar(
          title: "Profile Information",
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLogged) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: const Text(
                            'Profile Pengguna',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            title: "First Name",
                            data: state.user.firstName,
                          ),
                        ),Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            title: "Last Name",
                            data: state.user.lastName,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            title: "Email",
                            data: state.user.email,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            title: "Phone Number",
                            data:  state.user.phoneNumber,
                          ),
                        ),
                      ]),
                )
              ],
            );
          } else {
            return SizedBox();
          }
        }
        )
    );
  }
}
