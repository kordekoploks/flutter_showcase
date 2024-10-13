import 'package:flutter/material.dart';

class VwAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBackPressed;

  const VwAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_left),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      centerTitle: true,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}



