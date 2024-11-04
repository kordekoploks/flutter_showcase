import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';

class MenuItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Icon? icon;
  const MenuItemCard({
    Key? key,
    required this.title,
    this.onClick,
    this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                  const  Icon(Icons.keyboard_arrow_right,color: Colors.grey,),

                ],
              ),
              Divider( height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 5,
                color: Colors.black12,)
            ],
          ),
        ),
      ),
    );
  }
}
