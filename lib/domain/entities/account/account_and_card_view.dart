import 'dart:ffi';

import 'package:eshop/domain/entities/account/account.dart';
import 'package:eshop/domain/entities/account/account_tabbar.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';

import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/util/UuidHelper.dart';
import '../../../data/models/account/account_model.dart';
import '../../../presentation/blocs/account/account_bloc.dart';
import '../../../presentation/blocs/category/category_bloc.dart';
import '../../../presentation/blocs/user/user_bloc.dart';
import 'account_bottom_sheet/account_add_bottom_sheet.dart';
import 'account_bottom_sheet/spinner_choose_group.dart';

class AccountAndCardView extends StatefulWidget {
  AccountAndCardView({Key? key}) : super(key: key);

  @override
  State<AccountAndCardView> createState() => _AccountAndCardViewState();
}

String getInitials(String fullName) {
  List<String> nameParts = fullName.trim().split(' ');
  return nameParts
      .map((part) => part.isNotEmpty ? part[0].toUpperCase() : '')
      .join();
}

class _AccountAndCardViewState extends State<AccountAndCardView> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryNumberController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Account> _data = [];

  @override
  void initState() {
    String fullName = "John Doe";
    String initials = getInitials(fullName);
    super.initState();
    _fetchData();
  }

  void main() {}

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
    context.read<AccountBloc>().add(const GetAccount());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoaded) {
            _setData(state);
          } else if (state is AccountAdded) {
            _addSubAccount(state);
          } else if (state is AccountDeleted) {
            _removeSubAccount(state);
          } else if (state is AccountUpdated) {
            _updateAccount(state);
          } else if (state is AccountEmpty) _emptyData(state);
        },
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddAccountBottomSheet(context),
            label: Text(
              'Add',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            backgroundColor: vWPrimaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Expanded(child: buildContent(context)),
              ],
            ),
          ),
        ));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kEmpty),
          const SizedBox(height: 16),
          Text("Categories is not found!", textAlign: TextAlign.center),
          IconButton(
            onPressed: () =>
                context.read<AccountBloc>().add(const GetAccount()),
            //todo untuk membaca bahwa kategori lengit terus munculkan tobol repres yg di drag
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  void _setData(AccountLoaded state) {
    setState(() {
      _data.clear();
      _data.addAll(state.data);
    });
  }

  void _emptyData(AccountEmpty state) {
    setState(() {
      _data.clear();
    });
  }

  void _addSubAccount(AccountAdded state) {
    _data.add(state.dataAdded);

    // Trigger the animation for the new item

    if (_data.length == 1) {
      _listKey.currentState?.insertItem(0);
      setState(() {}); // This will trigger a rebuild and show the empty state
    } else {
      _listKey.currentState?.insertItem(_data.length - 1);
    }
  }

  void _removeSubAccount(AccountDeleted state) {
    final index = _data.indexOf(state.dataDeleted);
    // if (index >= 0) {
    //   _listKey.currentState?.removeItem(
    //     index,
    //         (context, animation) =>
    //         _buildAccountItem(context, state.dataDeleted, animation, index),
    //   );
    _data.removeAt(index);
  }

  void _updateAccount(AccountUpdated state) {
    final index = _data.indexWhere(
      (subAccount) => subAccount.id == state.dataUpdated.id,
    );
    if (index >= 0) {
      setState(() {
        _data[index] = state.dataUpdated.copyWith(isUpdated: true);
      });
    }
  }

  void _showAddAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AccountAddBottomSheet(onSave: (name) {
          final currentState = context.read<AccountBloc>().state;
          int position =
              currentState is AccountLoaded ? currentState.data.length + 1 : 0;

          final newAccount = AccountModel(
              id: UuidHelper.generateNumericUUID(),
              name: name,
              desc: '$name Description here',
              initialAmt: 0.0,
              accountGroup: GROUP_CASH);
          // tombol add terusan dari atas
          context.read<AccountBloc>().add(AddAccount(newAccount));
        });
      },
    );
  }

  // Widget _buildErrorState(BuildContext context, AccountError state) {
  //   final imagePath = state.failure is NetworkFailure
  //       ? 'assets/status_image/no-connection.png'
  //       : 'assets/status_image/internal-server-error.png';
  //   final message = state.failure is NetworkFailure
  //       ? "Network failure\nTry again!"
  //       : "Categories not found!";
  // }
  @override
  Widget buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: VwAppBar(
        title: "Account And Card",
        transparantMode: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AccountTabBar(
                tabs: [
                  AccountTabItem(name: "Account"),
                  AccountTabItem(name: "Card")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    height: 400,
                    color: vWPrimaryColor,
                    child: Align(
                        alignment: Alignment.center,
                        child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                          if (state is UserLogged) {
                            return Text(
                              getInitials(state.user.firstName +
                                  " " +
                                  state.user.lastName),
                              style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
                  ),
                  // Image.asset("account_bg.png"),
                  Align(
                    alignment: Alignment(0, 0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 320),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Cash 1",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "1900 8988 1234",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Avaible Balance",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "Rp.20.000",
                                              style: TextStyle(
                                                  color: vWPrimaryColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Avaible Balance",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "Rp.20.000",
                                              style: TextStyle(
                                                  color: vWPrimaryColor,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ))
                              ],
                            ),
                          ),
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
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Cash 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "1900 8988 1234",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Avaible Balance",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "Rp.20.000",
                                            style: TextStyle(
                                                color: vWPrimaryColor,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Avaible Balance",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "Rp.20.000",
                                            style: TextStyle(
                                                color: vWPrimaryColor,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
