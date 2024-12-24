import 'package:flutter/material.dart';

class VwAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBackPressed;
  final bool? transparantMode;

  const VwAppBar(
      {Key? key, required this.title, this.onBackPressed, this.transparantMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          size: 40,
          color: transparantMode != null && transparantMode!
              ? Colors.white
              : Colors.grey,
        ),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transparantMode != null && transparantMode!
                ? Colors.white
                : Colors.grey),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
