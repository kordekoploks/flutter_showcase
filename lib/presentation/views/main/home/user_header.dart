import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../blocs/user/user_bloc.dart';

class UserHeader extends StatelessWidget {
  const UserHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLogged) {
          return Row(
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.userProfile),
                child: Text(
                  "${state.user.firstName} ${state.user.lastName}",
                  style: const TextStyle(fontSize: 26),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.userProfile),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: state.user.image != null
                      ? CachedNetworkImageProvider(state.user.image!)
                      : const AssetImage(kUserAvatar) as ImageProvider,
                ),
              ),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(l10n.welcome,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 36)),
                Text(l10n.listOfProduct, style: const TextStyle(fontSize: 22)),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRouter.signIn),
              child: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(kUserAvatar),
              ),
            ),
          ],
        );
      },
    );
  }
}
