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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle,
            ),
            arrowIcon, // Add the arrow icon
          ],
        ),
      ),
    );
  }
}
