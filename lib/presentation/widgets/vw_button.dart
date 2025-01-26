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
    return Stack(
      children: [
        if (buttonType == ButtonType.border)
          _buildDottedBorder(),
        ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(padding),
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
            backgroundColor: MaterialStateProperty.all(
              buttonType == ButtonType.border ? Colors.transparent : _getBackgroundColor(),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            elevation: MaterialStateProperty.all(buttonType == ButtonType.border ? 0 : 2),
          ),
          child: titleText != null
              ? Text(
            titleText!,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
              fontWeight: FontWeight.bold,
              color: _getTextColor(),
            ),
          )
              : icon ??
              Icon(
                Icons.star,
                color: buttonType == ButtonType.border
                    ? Colors.black // Ensure contrast for the border button
                    : Colors.white,
              ),
        ),
      ],
    );
  }

  Widget _buildDottedBorder() {
    return Positioned.fill(
      child: CustomPaint(
        painter: DottedBorderPainter(
          borderColor: Colors.black, // Set this to a visible color for testing
          borderRadius: 12.0,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
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

  Color _getTextColor() {
    return buttonType == ButtonType.border ? vWPrimaryColor : Colors.white;
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderRadius;

  DottedBorderPainter({required this.borderColor, this.borderRadius = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dashWidth = 5.0;
    final dashSpace = 3.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rect);
    final PathMetrics pathMetrics = path.computeMetrics();

    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final Path extractedPath = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractedPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
    debugPrint('Dotted border painted'); // Debug to confirm rendering
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

enum ButtonType { primary, secondary, link, border }
