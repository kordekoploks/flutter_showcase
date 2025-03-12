import 'package:eshop/domain/entities/image/IconSelection.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';


class IconItemCard extends StatefulWidget {
  final IconSelection listIcon;
  final int index;
  final VoidCallback onAnimationEnd;
  final VoidCallback onTap; // New parameter for handling clicks

  const IconItemCard({
    Key? key,
    required this.listIcon,
    required this.index,
    required this.onAnimationEnd,
    required this.onTap, // Optional tap handler
  }) : super(key: key);

  @override
  _IconItemCardState createState() => _IconItemCardState();
}

class _IconItemCardState extends State<IconItemCard> {
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
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.listIcon.icon,
                color:
                isSelected ? Colors.white : Colors.black45, // Change icon color
              ),SizedBox(height: 6,),
              Text(
                widget.listIcon.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  // Adjust text color
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          // leading: Icon(
          //   widget.listIcon.icon,
          //   color:
          //   isSelected ? Colors.white : Colors.black45, // Change icon color
          // ),
        ),
      ),
    );
  }
}
