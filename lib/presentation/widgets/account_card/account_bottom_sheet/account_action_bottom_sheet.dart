import 'package:eshop/domain/entities/account/account.dart';
import 'package:flutter/material.dart';
import 'package:eshop/presentation/widgets/menu_bottom_sheet_item_card.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';


class AccountActionBottomSheet extends StatefulWidget {
  final Function(Account) onEdit;
  final Function(Account) onDelete;
  final Account account;

  const AccountActionBottomSheet({
    Key? key,
    required this.account,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _AccountActionBottomSheetState createState() =>
      _AccountActionBottomSheetState();
}

class _AccountActionBottomSheetState extends State<AccountActionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "${widget.account.name} Action",
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuBottomSheetItemCard(
              title: "Edit",
              icon: Icon(Icons.edit, color: Colors.grey.withOpacity(0.5)),
              onClick: () {
                Navigator.pop(context); // Close the current bottom sheet
                widget.onEdit(widget.account);
              },
            ),
            MenuBottomSheetItemCard(
              title: "Delete",
              icon: Icon(
                Icons.delete,
                color: Colors.grey.withOpacity(0.5),
              ),
              onClick: () {
                Navigator.pop(context); // Close the current bottom sheet
                widget.onDelete(widget.account);
              },
            ),
          ],
        ),
      ),
    );
  }
}
