import 'package:flutter/material.dart';

class VwSpinner extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double height;
  final double width;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final Icon arrowIcon;
  final bool isValid; // Validation flag
  final String validationMessage; // Validation message

  const VwSpinner({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderRadius = 20.0,
    this.height = 60.0,
    this.width = double.infinity,
    this.textStyle = const TextStyle(color: Colors.grey, fontSize: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.arrowIcon = const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
    this.isValid = true,
    this.validationMessage = "Please select an item.",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isValid ? borderColor : Colors.red, // Highlight border if invalid
            ),
          ),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: textStyle.copyWith(
                    color: isValid ? textStyle.color : Colors.red, // Change text color if invalid
                  ),
                ),
                arrowIcon,
              ],
            ),
          ),
        ),
        if (!isValid) // Show validation message if not valid
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              validationMessage,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
