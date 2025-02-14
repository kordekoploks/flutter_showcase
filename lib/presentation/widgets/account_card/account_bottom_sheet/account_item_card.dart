import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../../domain/entities/account/account.dart';

class AccountItemCard extends StatefulWidget {
  final Account subAccount;
  final int index;
  final VoidCallback onAnimationEnd;
  final VoidCallback onTap; // New parameter for handling clicks

  const AccountItemCard({
    Key? key,
    required this.subAccount,
    required this.index,
    required this.onAnimationEnd,
    required this.onTap, // Optional tap handler
  }) : super(key: key);

  @override
  _AccountItemCardState createState() => _AccountItemCardState();
}

class _AccountItemCardState extends State<AccountItemCard> {
  static int? _selectedIndex; // Track selected item

  @override
  Widget build(BuildContext context) {
    bool isSelected = _selectedIndex == widget.index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = widget.index; // Update selected index
        });

        widget.onTap(); // Trigger the external tap handler
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // Smooth animation
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? vWPrimaryColor : Colors.white,
          // Highlight selection
          borderRadius: BorderRadius.circular(12.0),
        ),
        onEnd: widget.onAnimationEnd,
        child: ListTile(
          title: Text(
            widget.subAccount.name,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              // Adjust text color
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(
            "Amount: ${widget.subAccount.initialAmt}", // Display initialAmt
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.black54, // Adjust subtitle color
            ),
          ),
          leading: Icon(
            Icons.account_circle,
            color:
                isSelected ? Colors.white : Colors.black45, // Change icon color
          ),
        ),
      ),
    );
  }
}
