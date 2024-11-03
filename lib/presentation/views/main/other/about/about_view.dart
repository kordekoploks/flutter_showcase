import 'package:eshop/presentation/views/main/other/about/about_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../blocs/user/user_bloc.dart';


class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Information"),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            const Text(
              'CaBank E-mobile Banking',
              style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
        //Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const Text(
        //             'CaBank E-mobile Banking',
        //             style:
        //                 TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(height: 15),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text(
        //                 'Date of manufacture',
        //                 style: TextStyle(
        //                     fontSize: 15, fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 "Dec 2019",
        //                 style: TextStyle(
        //                     color: vWPrimaryColor,
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text(
        //                 'Version',
        //                 style: TextStyle(
        //                     fontSize: 15, fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 "9.0.2",
        //                 style: TextStyle(
        //                     color: vWPrimaryColor,
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text(
        //                 'Language',
        //                 style: TextStyle(
        //                     fontSize: 15, fontWeight: FontWeight.bold),
        //               ),
        //               Text(
        //                 "English",
        //                 style: TextStyle(
        //                     color: vWPrimaryColor,
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold),
        //               ),
        //             ],
        //           ),
        //
        //         ],
        //     ),
        // ),

      ),
      )
          ],
    )
    );
  }
}
