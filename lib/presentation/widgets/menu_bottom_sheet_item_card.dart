import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuBottomSheetItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Widget? icon;
  const MenuBottomSheetItemCard({
    Key? key,
    required this.title,
    this.onClick,
    this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
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
                  Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.left,
                    ),
                  ),
                    Icon(Icons.keyboard_arrow_right, color: Colors.grey.withOpacity(0.5) ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
