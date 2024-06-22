import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

// Example usage:
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: 'My Custom AppBar',
          onBackPressed: () {
            // Handle custom back press action
            print('Custom back press action');
          },
        ),
        body: Center(
          child: Text('Hello, world!'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
