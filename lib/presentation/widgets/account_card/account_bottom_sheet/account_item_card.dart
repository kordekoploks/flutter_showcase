import 'package:flutter/material.dart';

import '../../../../domain/entities/account/account.dart';

class AccountItemCard extends StatefulWidget {
  final Account subAccount;
  final int index;
  final VoidCallback onAnimationEnd;

  const AccountItemCard({
    Key? key,
    required this.subAccount,
    required this.index,
    required this.onAnimationEnd,
  }) : super(key: key);

  @override
  _AccountItemCardState createState() =>
      _AccountItemCardState();
}

class _AccountItemCardState extends State<AccountItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0), // Add margin around the container
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        onEnd: widget.onAnimationEnd,
        child: ListTile(
          title: Text(widget.subAccount.name),
      ),
    ));
  }
}
