import 'package:flutter/material.dart';

class MoneyTextController extends TextEditingController {
  MoneyTextController({String initialText = ''}) {
    text = initialText;
  }

  /// Parses the current text (with currency and formatting) into a double
  double get parsedValue {
    final cleanedText = text.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanedText) ?? 0.0;
  }

  /// Sets the value and automatically formats it as money
  void setMoneyValue(double value, {String currency = 'Rp'}) {
    final formatted = _formatMoney(value, currency);
    text = formatted;
  }

  /// Internal method to format a double value into a money string
  String _formatMoney(double value, String currency) {
    return '$currency ${value.toStringAsFixed(2)}';
  }
}
