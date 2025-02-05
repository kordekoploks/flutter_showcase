import 'package:eshop/presentation/blocs/category/outcome_category_bloc.dart';
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

  const AccountBottomSheet({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  _AccountBottomSheetState createState() =>
      _AccountBottomSheetState();
}

class _AccountBottomSheetState extends State<AccountBottomSheet> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Account> _subAccount = [];

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
      child: VWBottomSheet(
        title: "${widget.account.name} Account",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          ],
        ),
      ),
    );
  }


  void _setAccount(AccountLoaded state) {
    setState(() {
      _subAccount.clear();
      _subAccount.addAll(state.data);
    });
  }


  void _emptyAccount() {
    setState(() {
      _subAccount.clear();
    });
  }

  Widget _buildAccountContent() {
    if (_subAccount.isEmpty) {
      return _buildEmptyState();
    } else {
      // Use FutureBuilder to ensure AnimatedList is built after setState() is called
      return FutureBuilder(
        future: Future.delayed(Duration.zero), // Delays the build to ensure proper rendering
        builder: (context, snapshot) {
          return SizedBox(
            height: 300,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _subAccount.length,
              itemBuilder: (context, index, animation) {
                final account = _subAccount[index];
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



  Widget _buildAccountItemCard(BuildContext context, Account account, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: AccountItemCard(
        subAccount: account,
        index: index,
        onAnimationEnd: () {
          setState(() {
            _subAccount[index] = _subAccount[index].copyWith(isUpdated: false);
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
