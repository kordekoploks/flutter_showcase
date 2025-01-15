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
import '../../../presentation/blocs/category/category_bloc.dart';
import '../../../presentation/blocs/user/user_bloc.dart';
import '../../../presentation/views/main/other/profile/profile_item_card.dart';
import '../../../presentation/views/main/other/profile/profile_screen.dart';
import '../user/user.dart';

class AccountAndCardView extends StatefulWidget {
  User user;
  AccountAndCardView({Key? key, required this.user}) : super(key: key);

  @override
  State<AccountAndCardView> createState() => _AccountAndCardViewState();
}
String getInitials(String fullName) {
  List<String> nameParts = fullName.trim().split(' ');
  return nameParts.map((part) => part.isNotEmpty ? part[0].toUpperCase() : '').join();}


class _AccountAndCardViewState extends State<AccountAndCardView> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController categoryNumberController =
  TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    String fullName = "John Doe";
    String initials = getInitials(fullName);
    super.initState();
  }

  void main() {
  }

  void _showSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(16.0),
        content: Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        duration: const Duration(seconds: 5),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.0),
      ),
    );
  }



  void _fetchData() {
    context.read<OutcomeCategoryBloc>().add(const GetCategories());
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: VwAppBar(
        title: "Account And Card",
        transparantMode: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 400,
                color: vWPrimaryColor,
                child:  Align(
                  alignment: Alignment.center,
                  child: Text(
                    getInitials(widget.user.firstName + " " + widget.user.lastName),
                    style: TextStyle(fontSize: 60, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Align(
                alignment: Alignment(0,0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 370),
                      height:290 ,
                      width: 360,
                      child: Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
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
                        ),
                      ),),
                    SizedBox(height: 20,),
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
            ],
          ),
        ),
      ),
    );
  }
}
