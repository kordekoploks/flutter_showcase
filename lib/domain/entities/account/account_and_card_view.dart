import 'package:eshop/domain/entities/account/account_tabbar.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';

import '../../../core/constant/images.dart';
import '../../../presentation/blocs/cart/cart_bloc.dart';
import '../../../presentation/blocs/user/user_bloc.dart';
import '../../../presentation/views/main/other/profile/profile_item_card.dart';

class AccountAndCardView extends StatefulWidget {
  const AccountAndCardView({Key? key}) : super(key: key);

  @override
  State<AccountAndCardView> createState() => _AccountAndCardViewState();
}

class _AccountAndCardViewState extends State<AccountAndCardView> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryNumberController =
  TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: AppLocalizations.of(context)!.loading);
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          EasyLoading.showError(AppLocalizations.of(context)!.error);
        }
      },
      child: Scaffold(
        appBar: VwAppBar(title: "Account And Card"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              AccountTabBar(
                tabs: [
                  AccountTabItem(
                    icon: Icons.wallet,
                    name: "Account",
                    // content: Center(
                    //   // child: Text(
                    //   //   "Income Content",
                    //   //   style: TextStyle(fontSize: 16),
                    //   // ),
                    // ),
                  ),
                  AccountTabItem(
                    icon: Icons.money_off,
                    name: "Card",
                    // content: Center(
                    //   child: Text(
                    //   "Income Content",
                    //   style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  radius: 36.0,
                  backgroundImage: AssetImage(kUserAvatar),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Smtity weber jansen",
                style: TextStyle(
                    color: vWPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    height: 120,
                    width: 360,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cash 1", style: TextStyle(fontWeight: FontWeight
                                .bold, fontSize: 15),),
                            Text("1900 8988 1234",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15),)
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Avaible Balance",
                              style: TextStyle(color: Colors.grey, fontSize: 15),),
                            Text("Rp.20.000",
                              style: TextStyle(color: Colors.grey, fontSize: 15),),
                          ],
                        ), Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Avaible Balance",
                            style: TextStyle(color: Colors.grey, fontSize: 15),),
                          Text("Rp.20.000",
                            style: TextStyle(color: Colors.grey, fontSize: 15),),
                        ],
                                            ),
                          ]
                                            ),
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Container(
                    height: 120,
                    width: 360,
                    child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Cash 1", style: TextStyle(fontWeight: FontWeight
                                        .bold, fontSize: 15),),
                                    Text("1900 8988 1234",
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 15),)
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Avaible Balance",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    Text("Rp.20.000",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                  ],
                                ), Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Avaible Balance",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    Text("Rp.20.000",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                  ],
                                ),
                              ]
                          ),
                        )
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Container(
                    height: 120,
                    width: 360,
                    child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Cash 1", style: TextStyle(fontWeight: FontWeight
                                        .bold, fontSize: 15),),
                                    Text("1900 8988 1234",
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 15),)
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Avaible Balance",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    Text("Rp.20.000",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                  ],
                                ), Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Avaible Balance",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    Text("Rp.20.000",
                                      style: TextStyle(color: Colors.grey, fontSize: 15),),
                                  ],
                                ),
                              ]
                          ),
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
