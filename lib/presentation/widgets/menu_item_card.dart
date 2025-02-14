import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Icon? icon;

  const MenuItemCard({
    Key? key,
    required this.title,
    this.onClick,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Reduced padding
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      icon!.icon,
                      size: 20, // Adjusted icon size
                      color: icon!.color ?? Colors.black,
                    ),
                  ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16, // Adjusted font size
                    color: Colors.black54
                  ),
                ),
                const SizedBox(width: 8), // Space between text and arrow
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 20, // Adjusted arrow size
                ),
              ],
            ),
            SizedBox(height: 10,),
            const Divider(
              height: 16, // Adjusted spacing
              thickness: 1, // Slightly thinner divider
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}
