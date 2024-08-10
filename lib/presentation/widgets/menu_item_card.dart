import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          color: Colors.white,
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
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
          ),
        ),
      ),
    );
  }
}
