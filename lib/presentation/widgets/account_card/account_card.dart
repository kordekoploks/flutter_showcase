import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/account/account.dart';
import 'package:eshop/presentation/blocs/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/colors.dart';
import '../../../data/models/account/account_model.dart';
import '../../../domain/entities/category/outcome_category.dart';
import '../../blocs/account/account_bloc.dart';


class AccountCard extends StatefulWidget {
  final Account? account;
  final int index;
  final Function? onClick;
  final Function(Account)? onClickMoreAction;
  final Function(AccountModel)? onUpdate;
  final bool isUpdated;
  final VoidCallback onAnimationEnd;


  const AccountCard({
    Key? key,
    this.account,
    required this.index,
    this.onClick,
    this.onClickMoreAction,
    this.onUpdate,
    required this.isUpdated,
    required this.onAnimationEnd
  }) : super(key: key);

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final GlobalKey _listKey = GlobalKey();

  AccountModel? _updatedAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child:
        BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
          return _buildAccountContent(context);
        }));
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.white,
      child: _buildAccountContent(context),
    );
  }

  Widget _buildAccountContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category click
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildAccountHeader(),
            ],
          ),
          Container(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Container(
                  width: constraint.maxWidth * 0.95,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                  ), //todo container base
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountHeader() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: widget.isUpdated ? vWPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      onEnd: widget.onAnimationEnd,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // _buildAccountImage(),
            _buildAccountDetails(),
            // _buildExpandIcon(),
            _buildMoreActionsIcon(),
          ],
        ),
      ),
    );
  }   //todo animasi saat mendi kuning


  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }

  Widget _buildAccountDetails() {
    return Expanded(
      flex: 7,
      child: SizedBox(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 4, 0),
              child: widget.account == null
                  ? _buildPlaceholderText(width: 120)
                  : Text(
                widget.account!.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 4, 0),
              child: Row(
                children: [
                  SizedBox(
                    height: 18,
                    child: widget.account == null
                        ? _buildPlaceholderText(width: 100)
                        : Text(
                      widget.account!.desc,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderText({required double width}) {
    return Container(
      width: width,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildMoreActionsIcon() {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () {
          if (widget.onClickMoreAction != null && widget.account != null) {
            widget.onClickMoreAction!(widget.account!);
          }
        },
        child: const Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
      ),
    );
  }



}
