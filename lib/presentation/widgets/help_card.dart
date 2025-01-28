import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  final String title;
  final String text;
  final String text2;
  final Function()? onClick;
  final Icon? icon;

  const HelpCard({
    Key? key,
    required this.title,
    required this.text,
    required this.text2,
    this.onClick,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick, // Gesture detector applies to the entire row and divider
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: icon,
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 18,color: vWPrimaryColor),
                      ),
                      Text(
                        text,
                        style: TextStyle(fontSize: 14,color: Colors.grey),
                      ),
                      Text(
                        text2,
                         style: TextStyle(fontSize: 14,color: Colors.grey),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 2,
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}
