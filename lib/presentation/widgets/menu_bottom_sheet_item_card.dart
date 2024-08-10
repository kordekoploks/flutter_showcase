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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const  Icon(Icons.keyboard_arrow_right),

                ],
              ),
              const Divider(color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
