import 'package:eshop/core/util/money_text_controller.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/presentation/views/main/other/income_ui/tabbar.dart';
import 'package:eshop/presentation/widgets/input_money_form_field.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:eshop/presentation/widgets/vw_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/util/UuidHelper.dart';

import '../../../../data/models/account/account_model.dart';
import '../../../../data/models/income/income_model.dart';
import '../../../../domain/entities/account/account.dart';
import '../../../../domain/entities/account/account_bottom_sheet/spinner_choose_group.dart';
import '../../../../domain/entities/account/account_bottom_sheet/vw_spinner.dart';
import '../../../../domain/entities/income/income_bottom_sheet/account_spinner.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../blocs/income/income_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/input_text_form_field.dart';
import '../../../widgets/income_category/income_tab_bar.dart';
import '../../../widgets/outcome_category/outcome_category_item_card.dart';
import '../../../widgets/vw_checkbox.dart';
import '../../../widgets/vw_text_link.dart';
import '../outcome_category/bottom_sheet/outcome_category_bottom_sheet.dart';
import 'account_bottom_sheet.dart';

class IncomeAddView extends StatefulWidget {
  const IncomeAddView({Key? key}) : super(key: key);

  @override
  State<IncomeAddView> createState() => _IncomeAddViewState();
}

class _IncomeAddViewState extends State<IncomeAddView> {
  final TextEditingController dateController = TextEditingController();
  final MoneyTextController amountController = MoneyTextController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isValid = true;

  final List<String> _tabTitles = ["INCOME", "EXPENSE"];
  int _selectedIndex = 0;
  String selectedGroup = "Category";
  late DateTime _chosenDateTime;

  @override
  void initState() {
    super.initState();
  }

  void main() {
    EasyLoading.init();
  }

  // Show the modal that contains the CupertinoDatePicker
  void _showDateCoy(BuildContext ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.dateAndTime, // Includes hour selection
                use24hFormat: true, // 24-hour format (optional)
                onDateTimeChanged: (DateTime val) {
                  setState(() {
                    _chosenDateTime = val;
                    DateTime today = DateTime.now();
                    bool isToday = val.year == today.year &&
                        val.month == today.month &&
                        val.day == today.day;

                    String formattedDate = isToday
                        ? "Today"
                        : "${val.month}/${val.day}/${val.year}";

                    dateController.text =
                    "$formattedDate ${val.hour}:${val.minute.toString().padLeft(2, '0')}"; // Format Date
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      ),
    );

  }

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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58), // Height of the app bar
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {},
                    ),
                    Text(
                      "Transaction",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 4),
                  child: GestureDetector(
                    onTap: () {
                      _showAccountBottomSheet(context, Account(
                          id: "",name: "",initialAmt: 0,desc: "",isUpdated: false)
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CASH",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 38,
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        Text(
                          "Balance: 10.000",
                          style: TextStyle(
                              color: vWPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Choose transaction",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              VwTabBar(
                titles: _tabTitles,
                selectedIndex: _selectedIndex,
                onTabTapped: (index) {
                  setState(() {
                    _selectedIndex = index; // Update the selected tab index.
                  });
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showDateCoy(context);
                                },
                                child: AbsorbPointer(
                                  // Prevents the keyboard from showing up
                                  child: InputTextFormField(
                                    hint: "date",
                                    controller: dateController,
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
                                    color: vWPrimaryColor,
                                    // Yellow border color
                                    width: 2, // Thickness of the border
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                // Button background color
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 27,
                                  vertical: 17,
                                ),
                                minimumSize: const Size(100, 50), // Button size
                              ),
                              child: Text(
                                "Repeat",
                                style: TextStyle(
                                  color: vWPrimaryColor,
                                  // Text color matching the border
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InputMoneyFormField(
                          hint: "amount",
                          controller: amountController,
                        ),
                        const SizedBox(height: 0),
                        GestureDetector(
                          onTap: () async {
                            final selectedCategory = await _showOutcomeCategoryBottomSheet(context);
                            if (selectedCategory != null) {
                              setState(() {
                                selectedCategoryName = selectedCategory.name; // Store selected category name
                              });
                            }
                          },
                          child: VwSpinner(
                            text: selectedCategoryName ?? "Category", // Display selected category
                            isValid: isValid,
                          ),
                        ),


                        // GestureDetector(
                        //   onTap: () {
                        //     showDialog<void>(
                        //       context: context,
                        //       builder: (context) => AlertDialog(
                        //         insetPadding: EdgeInsets.all(8),
                        //         backgroundColor: Colors.transparent,
                        //         content: Container(
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(16),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.black12.withOpacity(0.3),
                        //                 blurRadius: 12,
                        //                 spreadRadius: 2,
                        //                 offset: Offset(0, 4),
                        //               ),
                        //             ],
                        //           ),
                        //           child: AccountSpinner(
                        //             onClickGroup: (String accountGroup) {
                        //               setState(() {
                        //                 selectedGroup = accountGroup;
                        //               });
                        //               Navigator.of(context).pop();
                        //             },
                        //             selectedGroup: selectedGroup,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: AccountSpinner(
                        //     selectedGroup: selectedGroup,
                        //     onClickGroup: (String accountGroup) {
                        //       setState(() {
                        //         selectedGroup = accountGroup;
                        //       });
                        //       Navigator.of(context).pop();
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        InputTextFormField(
                          hint: "note",
                          controller: noteController,
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
                            final newIncome = IncomeModel(
                              id: UuidHelper.generateNumericUUID(),
                              idAccount: "0",
                              date: dateController.text,
                              amount: amountController.parsedValue,
                              category: categoryController.text,
                              note: noteController.text,
                              isRepeat: true,
                            );

                            context.read<IncomeBloc>().add(
                                AddIncome(newIncome));

                            // Show success toast
                            Fluttertoast.showToast(
                              msg: "Save Success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          titleText: "Confirm",
                          buttonType: ButtonType.primary,

                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAccountBottomSheet(BuildContext context, Account account) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AccountBottomSheet(
          account: account,
        );
      },
    );
  }

  Future<OutcomeCategory?> _showOutcomeCategoryBottomSheet(BuildContext context) async {
    return await showModalBottomSheet<OutcomeCategory>(
      context: context,
      builder: (context) {
        return OutcomeCategoryBottomSheet(
          onCategorySelected: (category) {
                      },
        );
      },
    );
  }


}
