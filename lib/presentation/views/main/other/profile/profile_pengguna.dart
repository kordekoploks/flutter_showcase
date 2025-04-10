import 'package:eshop/presentation/views/main/other/profile/profile_item_card.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/vw_appbar.dart';

class ProfilePengguna extends StatelessWidget {
  const ProfilePengguna({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: AppLocalizations.of(context)!.profileInformation),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is! UserLogged) return const SizedBox();

          final user = state.user;

          return SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                Text(
                  AppLocalizations.of(context)!.profileUser,
                  style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                ...[
                  {
                    "title": AppLocalizations.of(context)!.firstName,
                    "data": user.firstName,
                  },
                  {
                    "title": AppLocalizations.of(context)!.lastName,
                    "data": user.lastName,
                  },
                  {
                    "title": "Email",
                    "data": user.email,
                  },
                  {
                    "title": AppLocalizations.of(context)!.phoneNumber,
                    "data": user.phoneNumber,
                  },
                ].map(
                      (item) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ProfileItemCard(
                      onClick: () => Navigator.of(context).pushNamed(AppRouter.orders),
                      title: item["title"]!,
                      data: item["data"]!,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                VwButton(
                  onClick: () => context.read<UserBloc>().add(SignOutUser()),
                  titleText: AppLocalizations.of(context)!.signOut,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
