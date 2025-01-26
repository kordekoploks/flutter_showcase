import 'package:eshop/domain/entities/account/account.dart';
import 'package:eshop/domain/entities/account/account_tabbar.dart';
import 'package:eshop/presentation/views/main/other/income_ui/tabbar.dart';
import 'package:eshop/presentation/views/main/other/settings/settings_view.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stretchy_header/stretchy_header.dart';

import '../../../../../core/constant/colors.dart';

import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/util/UuidHelper.dart';
import '../../../data/models/account/account_model.dart';
import '../../../presentation/blocs/account/account_bloc.dart';
import '../../../presentation/blocs/category/category_bloc.dart';
import '../../../presentation/blocs/user/user_bloc.dart';
import '../../../presentation/views/main/outcome_category/confirmation_bottom_sheet.dart';
import '../../../presentation/widgets/account_card/account_bottom_sheet/account_action_bottom_sheet.dart';
import '../../../presentation/widgets/account_card/account_bottom_sheet/account_edit_bottom_sheet.dart';
import '../../../presentation/widgets/account_card/account_card.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

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
          body: buildContent(context),
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
    if (index >= 0) {
      _listKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildAccountItem(context, state.dataDeleted, animation, index),
      );
    }
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
        return AccountAddBottomSheet(onSave: (name, initialAmt, desc, group) {
          final currentState = context.read<AccountBloc>().state;
          int position =
              currentState is AccountLoaded ? currentState.data.length + 1 : 0;

          final newAccount = AccountModel(
              id: UuidHelper.generateNumericUUID(),
              name: name,
              desc: desc,
              initialAmt: initialAmt,
              accountGroup: group);
          // tombol add terusan dari atas
          context.read<AccountBloc>().add(AddAccount(newAccount));
        });
      },
    );
  }

  Widget _buildAccountList(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: _buildAccountListView(
              context), // Extracted RefreshIndicator and AnimatedList logic
        ),
      ],
    );
  }

  Widget _buildAccountListView(BuildContext context) {
    if (_data.isEmpty) {
      return _buildEmptyState();
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<AccountBloc>().add(const GetAccount());
        },
        child: FutureBuilder(
          future: Future.delayed(Duration.zero),
          builder: (context, snapshot) {
            // Safeguard: Ensure _data is not modified during the build phase
            if (_data.isEmpty) {
              return _buildEmptyState();
            }

            return AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              // Ensure this matches _data's length
              padding: EdgeInsets.only(
                top: 28,
                bottom: 80 + MediaQuery.of(context).padding.bottom,
              ),
              itemBuilder: (context, index, animation) {
                if (index >= _data.length) {
                  // Prevent accessing out-of-bound indexes
                  return const SizedBox.shrink();
                }

                final accountModel = _data[index];
                return _buildAccountItem(
                    context, accountModel, animation, index);
              },
            );
          },
        ),
      );
    }
  }

  Widget _buildAccountItem(BuildContext context, Account accountModel,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: GestureDetector(
        child: AccountCard(
          account: accountModel,
          onClickMoreAction: (account) =>
              _showAccountActionBottomSheet(context, accountModel, index),
          onUpdate: (editedAccount) {
            context.read<AccountBloc>().add(UpdateAccount(editedAccount));
          },
          onAnimationEnd: () {
            setState(() {
              _data[index] = _data[index].copyWith(isUpdated: false);
            });
          },
          index: index,
          isUpdated: accountModel.isUpdated,
        ),
      ),
    );
  }

  void _showAccountActionBottomSheet(
      BuildContext context, Account accountModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AccountActionBottomSheet(
            account: accountModel,
            onEdit: (account) =>
                _showEditAccountBottomSheet(context, accountModel, index),
            onDelete: (account) => _showDeleteConfirmationBottomSheet(
                context, accountModel, index));
      },
    );
  }

  void _showEditAccountBottomSheet(
      BuildContext context, Account accountModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AccountEditBottomSheet(
          account: accountModel,
          onSave: (editedAccount) {
            context.read<AccountBloc>().add(UpdateAccount(editedAccount));
          },
        );
      },
    );
  }

  void _showDeleteConfirmationBottomSheet(
      BuildContext context, Account accountModel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ConfirmationBottomSheet(
          title: "Hapus Kategori",
          desc: Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(
                    text: "Apakah kamu yakin akan menghapus kategori "),
                TextSpan(
                  text: accountModel.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          positiveLabel: "Hapus",
          negativeLabel: "Tidak",
          onPositiveClick: () {
            context.read<AccountBloc>().add(DeleteAccount(accountModel));
          },
        );
      },
    );
  }

//
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 200.0,
                      floating: false,
                      actions: [],
                      collapsedHeight: 80,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: BlocBuilder<UserBloc, UserState>(
                                      builder: (context, state) {
                                        if (state is UserLogged) {
                                          return Text(
                                            '${state.user.firstName} ${state.user.lastName}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              Text(
                                "Personal Account",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        background: Container(
                          height: 380,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/account_bg.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLogged) {
                                      return Text(
                                        getInitials(
                                          '${state.user.firstName} ${state.user.lastName}',
                                        ),
                                        style: TextStyle(
                                          fontSize: 60,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: _data.isEmpty
                    ? Center(
                        child: Text("No accounts available. Pull to refresh."),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _fetchData();
                          },
                          child: AnimatedList(
                            key: _listKey,
                            initialItemCount: _data.length,
                            itemBuilder: (context, index, animation) {
                              return _buildAccountItem(
                                context,
                                _data[index],
                                animation,
                                index,
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ),
            VwButton(
              onClick: () {},
              titleText: "Change Password",
              buttonType: ButtonType.border,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAccountBottomSheet(context),
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
