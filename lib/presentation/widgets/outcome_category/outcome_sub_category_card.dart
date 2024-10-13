import 'package:flutter/material.dart';

import '../../../core/constant/colors.dart';
import '../../../domain/entities/category/outcome_sub_category.dart';

class OutcomeSubCategoryCard extends StatefulWidget {
  final OutcomeSubCategory subCategory;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isUpdated;
  final VoidCallback onAnimationEnd;

  const OutcomeSubCategoryCard({
    Key? key,
    required this.subCategory,
    required this.index,
    required this.onEdit,
    required this.onDelete,
    required this.isUpdated,
    required this.onAnimationEnd,
  }) : super(key: key);

  @override
  _OutcomeSubCategoryCardState createState() =>
      _OutcomeSubCategoryCardState();
}

class _OutcomeSubCategoryCardState extends State<OutcomeSubCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0), // Add margin around the container
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: widget.isUpdated ? vWPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        onEnd: widget.onAnimationEnd,
        child: ListTile(
          title: Text(widget.subCategory.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: widget.onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
