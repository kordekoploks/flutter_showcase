import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/account/account.dart';
import 'package:eshop/presentation/blocs/category/outcome_category_bloc.dart';
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

  const AccountCard(
      {Key? key,
      this.account,
      required this.index,
      this.onClick,
      this.onClickMoreAction,
      this.onUpdate,
      required this.isUpdated,
      required this.onAnimationEnd})
      : super(key: key);

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final GlobalKey _listKey = GlobalKey();

  AccountModel? _updatedAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _buildAccountHeader(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountHeader() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (widget.onClickMoreAction != null && widget.account != null) {
            widget.onClickMoreAction!(
                widget.account!); // Trigger the onClick function
          }
        },
        child: AnimatedContainer(
          height: 120,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: widget.isUpdated ? vWPrimaryColor : Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: Colors.white, // Border color
              width: 2.0, // Border thickness
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color with transparency
                spreadRadius: 1, // How much the shadow spreads
                blurRadius: 4, // How blurry the shadow is
                offset: Offset(2, 2), // Horizontal and vertical shadow offset
              ),
            ],
          ),

        onEnd: widget.onAnimationEnd,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // Increased padding for a larger container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: widget.account == null
                          ? _buildPlaceholderText(width: 120)
                          : Text(
                        widget.account!.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: widget.account == null
                          ? _buildPlaceholderText(width: 120)
                          : Text(
                              widget.account!.accountGroup,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Initial Amt",
                      style: TextStyle(
                        fontSize: 14,color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: widget.account == null
                          ? _buildPlaceholderText(width: 120)
                          : Text(
                              widget.account!.initialAmt.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: vWPrimaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 4, 0),
                      child: widget.account == null
                          ? _buildPlaceholderText(width: 100)
                          : Text(
                              widget.account!.desc,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: vWPrimaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

// Widget _buildMoreActionsIcon() {
//   return Expanded(
//     flex: 2,
//     child: GestureDetector(
//       onTap: () {
//         if (widget.onClickMoreAction != null && widget.account != null) {
//           widget.onClickMoreAction!(widget.account!);
//         }
//       },
//       child: const Icon(
//         Icons.more_vert,
//         color: Colors.grey,
//       ),
//     ),
//   );
// }
}
