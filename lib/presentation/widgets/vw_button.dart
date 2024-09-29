import 'dart:ui';

import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';

class VwButton extends StatelessWidget {
  final VoidCallback onClick;
  final String? titleText;
  final Icon? icon;
  final EdgeInsetsGeometry padding;
  final ButtonType buttonType;

  const VwButton({
    Key? key,
    required this.onClick,
    this.titleText,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.buttonType = ButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
        backgroundColor: MaterialStateProperty.all(_getButtonColor()),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )),
      ),
      child: titleText != null
          ? Text(
        titleText!,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)
      )

          : icon ?? Image.asset(
        kFilterIcon,
        color: Colors.white,
      ),
    );
  }

  Color _getButtonColor() {
    switch (buttonType) {
      case ButtonType.secondary:
        return vWButtonSecondaryColor;
      case ButtonType.link:
        return vWButtonPrimaryColor;
      case ButtonType.primary:
      default:
        return vWButtonPrimaryColor;
    }
  }
}

enum ButtonType { primary, secondary, link }

