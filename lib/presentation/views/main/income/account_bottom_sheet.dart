import 'package:eshop/presentation/blocs/category/outcome_category_bloc.dart';
import 'package:eshop/presentation/widgets/VwFilterTextField.dart';
import 'package:eshop/presentation/widgets/account_card/account_bottom_sheet/account_search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Models & Entities
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/entities/category/outcome_sub_category.dart';

// Blocs

// Utilities & Constants
import '../../../../../core/constant/images.dart';
import '../../../../domain/entities/account/account.dart';
import '../../../blocs/account/account_bloc.dart';
import '../../../widgets/account_card/account_bottom_sheet/account_item_card.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/vw_bottom_sheet.dart';

class AccountBottomSheet extends StatefulWidget {
  final Account account;
  final ValueChanged<Account>? onSelectedItem; // Callback for selected item

  const AccountBottomSheet({
    Key? key,
    required this.account,
    this.onSelectedItem,
  }) : super(key: key);

  @override
  _AccountBottomSheetState createState() => _AccountBottomSheetState();
}

class _AccountBottomSheetState extends State<AccountBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Account> _listAccount = [];
  final TextEditingController _filterController = TextEditingController();
  late Account selectedAccount;

  @override
  void initState() {
    super.initState();
    _fetchAccount();
  }

  void _fetchAccount() {
    context.read<AccountBloc>().add(GetAccount());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoaded) {
            _setAccount(state);
          }
        },
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                Center(
                  child: Container(
                    width: 75,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: VwSearchTextField(
                        controller: _filterController,
                        showClearButton: false,
                        hintText: "Search Accounts...",
                        // Custom hint text
                        onChanged: (val) {
                          context.read<AccountBloc>().add(FilterAccounts(val));
                        },
                        onSubmitted: (val) {
                          context.read<AccountBloc>().add(FilterAccounts(val));
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [_buildAccountContent()],
                ), // Display the custom content here
              ],
            ),
          ),
        ));
  }

  void _setAccount(AccountLoaded state) {
    setState(() {
      _listAccount.clear();
      _listAccount.addAll(state.data);
    });
  }

  void _emptyAccount() {
    setState(() {
      _listAccount.clear();
    });
  }

  Widget _buildAccountContent() {
    if (_listAccount.isEmpty) {
      return _buildEmptyState();
    } else {
      // Use FutureBuilder to ensure AnimatedList is built after setState() is called
      return FutureBuilder(
        future: Future.delayed(Duration.zero),
        // Delays the build to ensure proper rendering
        builder: (context, snapshot) {
          return SizedBox(
            height: 300,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _listAccount.length,
              itemBuilder: (context, index, animation) {
                if (index >= _listAccount.length) {
                  // Prevent accessing out-of-bound indexes
                  return const SizedBox.shrink();
                }
                final account = _listAccount[index];
                return _buildAccountItemCard(
                  context,
                  account,
                  index,
                  animation,
                );
              },
            ),
          );
        },
      );
    }
  }

  Widget _buildAccountItemCard(BuildContext context, Account account, int index,
      Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: AccountItemCard(
        subAccount: account,
        index: index,
        onTap: () {
          widget.onSelectedItem?.call(account);
          Navigator.pop(context);
        },
        onAnimationEnd: () {
          setState(() {
            _listAccount[index] = _listAccount[index].copyWith(isUpdated: false);
          });
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const AlertCard(
      image: kEmpty,
      message: "Account not found!",
    );
  }
}
