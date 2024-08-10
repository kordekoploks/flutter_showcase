import 'package:flutter/material.dart';
import 'package:eshop/presentation/widgets/menu_bottom_sheet_item_card.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';

import '../../../../domain/entities/category/category.dart';
import 'category_edit_bottom_sheet.dart';

class CategoryActionBottomSheet extends StatefulWidget {
  final Function(Category) onEdit;
  final Function(Category) onDelete;
  final Category category;

  CategoryActionBottomSheet({
    Key? key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _CategoryActionBottomSheetState createState() =>
      _CategoryActionBottomSheetState();
}

class _CategoryActionBottomSheetState extends State<CategoryActionBottomSheet> {

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
            SizedBox(height: 16),
            MenuBottomSheetItemCard(
              title: "Edit",
              icon: Icon(Icons.edit),
              onClick: () {
                Navigator.pop(context);  // Close the current bottom sheet
                widget.onEdit(widget.category);
              },
            ),
            SizedBox(height: 16),
            MenuBottomSheetItemCard(
              title: "Delete",
              icon: Icon(Icons.delete),
              onClick: () {
                Navigator.pop(context);  // Close the current bottom sheet
                widget.onDelete(widget.category);
              },
            ),
          ],
        ),
      ),
    );
  }
}
