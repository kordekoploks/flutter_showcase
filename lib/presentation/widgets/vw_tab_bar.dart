import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

class VwTabBar extends StatelessWidget {
  final List<String> titles;
  final int selectedIndex;
  final Function(int) onTabTapped;

  VwTabBar({
    required this.titles,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(titles.length, (index) {
            return GestureDetector(
              onTap: () => onTabTapped(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: selectedIndex == index ? vWPrimaryColor : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: _calculateLinePosition(context, selectedIndex),
          width: _calculateTextWidth(context, titles[selectedIndex]) * 1.3, // Add 30% to the line width
          child: Container(
            height: 3,
            color: vWPrimaryColor,
            margin: EdgeInsets.only(top: 48), // Positioning the line below the text
          ),
        ),
      ],
    );
  }

  double _calculateTextWidth(BuildContext context, String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Bold for consistent measurement
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  double _calculateLinePosition(BuildContext context, int selectedIndex) {
    double position = 0.0;

    // Accumulate the widths and paddings of all previous titles
    for (int i = 0; i < selectedIndex; i++) {
      position += _calculateTextWidth(context, titles[i]) + 28.0; // Adjusted padding (horizontal 14.0 x 2)
    }

    // Add the left padding for the current title to center the line
    return position + 14.0; // Half of horizontal padding
  }
}
