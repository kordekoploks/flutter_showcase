import 'package:flutter/material.dart';
import 'package:eshop/presentation/widgets/menu_bottom_sheet_item_card.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';

import '../../../../../../domain/entities/category/income_category.dart';
import '../../../../../../domain/entities/category/outcome_category.dart';

class IncomeCategoryActionBottomSheet extends StatefulWidget {
  final Function(IncomeCategory) onEdit;
  final Function(IncomeCategory) onDelete;
  final Function(IncomeCategory) onSubCategories;
  final IncomeCategory category;

  const IncomeCategoryActionBottomSheet({
    Key? key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
    required this.onSubCategories
  }) : super(key: key);

  @override
  _IncomeCategoryActionBottomSheetState createState() =>
      _IncomeCategoryActionBottomSheetState();
}

class _IncomeCategoryActionBottomSheetState extends State<IncomeCategoryActionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "${widget.category.name} Action",
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuBottomSheetItemCard(
              title: "Sub Categories",
              icon: Icon(Icons.more_vert, color: Colors.grey.withOpacity(0.5)),
              onClick: () {
                Navigator.pop(context); // Close the current bottom sheet
                widget.onSubCategories(widget.category);
              },
            ),
            MenuBottomSheetItemCard(
              title: "Edit",
              icon: Icon(Icons.edit, color: Colors.grey.withOpacity(0.5)),
              onClick: () {
                Navigator.pop(context); // Close the current bottom sheet
                widget.onEdit(widget.category);
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
                widget.onDelete(widget.category);
              },
            ),
          ],
        ),
      ),
    );
  }
}
