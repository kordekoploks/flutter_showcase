import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeTabBar extends StatelessWidget {
  final List<String> titles;
  final int selectedIndex;
  final Function(int) onTabTapped;

  IncomeTabBar({
    required this.titles,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   height: 1,
        //   width: 15,
        //   color: Colors.grey,
        //   margin: EdgeInsets.only(top: 50), // Positioning the line below the text
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(titles.length, (index) {
            return GestureDetector(
              onTap: () => onTabTapped(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 46.0),
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == index
                            ? vWPrimaryColor
                            : Colors.black,
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
          width: _calculateTextWidth(context, titles[selectedIndex]),
          child: Container(
            height: 5,
            color: vWPrimaryColor,
            margin: EdgeInsets.only(top: 38), // Positioning the line below the text
          ),
        ),
      ],
    );
  }

  double _calculateTextWidth(BuildContext context, String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 40),
      ),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  double _calculateLinePosition(BuildContext context, int selectedIndex) {
    double position = 0.0;
    for (int i = 0; i < selectedIndex; i++) {
      position += _calculateTextWidth(context, titles[i]) + 40.0; // 32.0 is the assumed padding between items
    }
    return position + (40.0 / 2); // Adjusted position to center the line below the text
  }
}