import 'dart:ui';

import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:flutter/material.dart';

class VwButton extends StatelessWidget {
  final Function() onClick;
  final String? titleText;
  final Icon? icon;
  final EdgeInsets padding;
  final ButtonType buttonType;

  const VwButton({Key? key,
    required this.onClick,
    this.titleText,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.buttonType = ButtonType.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        maximumSize:
        MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        minimumSize:
        MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
            switch(buttonType){
              ButtonType.primary => vWButtonPrimaryColor,
              ButtonType.secondary => vWButtonSecondaryColor,
              ButtonType.link => vWButtonPrimaryColor
            }
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( 12.0)),
        ),
      ),
      child: titleText != null
          ? Text(
        titleText!,
        style: const TextStyle(color: Colors.black),
      )
          : Image.asset(
        kFilterIcon,
        color: Colors.white,
      ),
    );
  }
}

enum ButtonType { primary, secondary, link }
