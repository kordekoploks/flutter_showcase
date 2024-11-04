import 'package:eshop/presentation/views/main/other/about/about_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/vw_appbar.dart';


class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: "App Information",),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            SizedBox(
              child: const Text(
                'CaBank E-mobile Banking',
                style:
                TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              height: 40,
            ),
            SizedBox(height: 20,),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: AboutItemCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.orders);
                    },
                    title: "Date Of Manufacture", data: 'Dec 2019',
                  ),
                );
              },
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: AboutItemCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.orders);
                    },
                    title: "Version", data: '9.0.2',
                  ),
                );
              },
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: AboutItemCard(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.orders);
                    },
                    title: "Language", data: 'English',
                  ),
                );
              },
            ),
          ]
      ),
      )
          ],
    )
    );
  }
}
