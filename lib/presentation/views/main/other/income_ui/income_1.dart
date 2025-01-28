import 'package:eshop/presentation/views/main/other/income_ui/tabbar.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../blocs/cart/cart_bloc.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/input_text_form_field.dart';
import '../../../../widgets/vw_checkbox.dart';
import '../../../../widgets/vw_text_link.dart';

class Income1 extends StatefulWidget {
  const Income1({Key? key}) : super(key: key);

  @override
  State<Income1> createState() => _Income1State();
}

class _Income1State extends State<Income1> {
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
        appBar: VwAppBar(title: "Income 1"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chose account_card/ card",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Available balance: 10,000',
                style: TextStyle(color: vWPrimaryColor),
              ),
              const SizedBox(height: 30),
              Text(
                "Choose transaction",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              CustomTabBar(
                tabs: [
                  TabItem(
                    icon: Icons.wallet,
                    name: "Income",
                  ),
                  TabItem(
                    icon: Icons.money_off,
                    name: "Expense",
                  ),
                  TabItem(
                    icon: Icons.transfer_within_a_station,
                    name: "Transfer",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Date",
                              suffixIcon:
                                  Icon(Icons.keyboard_arrow_down_outlined),
                              hintStyle: TextStyle(color: Colors.black26),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: vWPrimaryColor, // Yellow border color
                                width: 2, // Thickness of the border
                              ),
                            ),
                            backgroundColor: Colors.white, // Button background color
                            padding: const EdgeInsets.symmetric(
                              horizontal: 27,
                              vertical: 17,
                            ),
                            minimumSize: const Size(100, 50), // Button size
                          ),
                          child: Text(
                            "Repeat",
                            style: TextStyle(
                              color: vWPrimaryColor, // Text color matching the border
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Amount",
                        hintStyle: TextStyle(color: Colors.black26),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Category",
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                        hintStyle: TextStyle(color: Colors.black26),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Note",
                        hintStyle: TextStyle(color: Colors.black26),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VwCheckbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Save to directory of beneficiary",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    VwButton(
                      onClick: () {

                        Navigator.of(context).pushNamed(
                          AppRouter.accountAndCardView,
                        );
                      },
                      titleText: "Confirm",
                      buttonType: ButtonType.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
