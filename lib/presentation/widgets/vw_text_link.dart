import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VwTextLink extends StatelessWidget {
  final Function()? onHelloClick;
  final String text;

  VwTextLink({this.onHelloClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onHelloClick,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: vWPrimaryColor),
        textAlign: TextAlign.start,
      ),
    );
  }
}
