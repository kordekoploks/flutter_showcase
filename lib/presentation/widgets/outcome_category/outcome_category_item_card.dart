import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../../domain/entities/account/account.dart';
import '../../../domain/entities/category/outcome_category.dart';

class OutcomeCategoryItemCard extends StatefulWidget {
  final OutcomeCategory subCategory;
  final int index;
  final VoidCallback onAnimationEnd;

  const OutcomeCategoryItemCard({
    Key? key,
    required this.subCategory,
    required this.index,
    required this.onAnimationEnd,
  }) : super(key: key);

  @override
  _OutcomeCategoryItemCardState createState() => _OutcomeCategoryItemCardState();
}
String? selectedCategoryName;
class _OutcomeCategoryItemCardState extends State<OutcomeCategoryItemCard> {
  static int? _selectedIndex; // Track selected item

  @override
  Widget build(BuildContext context) {
    bool isSelected = _selectedIndex == widget.index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = widget.index; // Update selected index
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Smooth animation
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? vWPrimaryColor : Colors.white, // Highlight selection
          borderRadius: BorderRadius.circular(12.0),
        ),
        onEnd: widget.onAnimationEnd,
        child: ListTile(
          title: Text(
            widget.subCategory.name,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black, // Adjust text color
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          leading: Icon(
            Icons.account_circle,
            color: isSelected ? Colors.white : Colors.black45, // Change icon color
          ),
        ),
      ),
    );
  }
}
