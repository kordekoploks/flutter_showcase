import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:flutter/material.dart';
import 'package:eshop/presentation/widgets/menu_bottom_sheet_item_card.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';

import '../../../../../../domain/entities/category/income_sub_category.dart';

class IncomeSubCategoryActionBottomSheet extends StatefulWidget {
  final Function(IncomeSubCategory) onEdit;
  final Function(IncomeSubCategory) onDelete;
  final IncomeSubCategory category;

  IncomeSubCategoryActionBottomSheet({
    Key? key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _IncomeSubCategoryActionBottomSheetState createState() =>
      _IncomeSubCategoryActionBottomSheetState();
}

class _IncomeSubCategoryActionBottomSheetState extends State<IncomeSubCategoryActionBottomSheet> {
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
              title: "Edit",
              icon: Icon(Icons.edit, color: Colors.grey.withOpacity(0.5)),
              onClick: () {
                Navigator.pop(context); // Close the current bottom sheet
                widget.onEdit(widget.category);
              },
            ),
            const SizedBox(height: 16),
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
