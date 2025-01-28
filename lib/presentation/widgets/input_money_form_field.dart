import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputMoneyFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final bool enable;
  final bool isBottomBorderOnly;
  final String? Function(String?)? validation;
  final bool isMandatory;
  final String currency; // Currency symbol to display ("$", "€", "Rp", etc.)

  const InputMoneyFormField({
    Key? key,
    required this.controller,
    this.hint,
    this.enable = true,
    this.isBottomBorderOnly = false,
    this.validation,
    this.isMandatory = false,
    this.currency = 'Rp', // Default to no symbol
  }) : super(key: key);

  @override
  _InputMoneyFormFieldState createState() => _InputMoneyFormFieldState();
}

class _InputMoneyFormFieldState extends State<InputMoneyFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    widget.controller.addListener(_formatToMoney);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(_formatToMoney);
    super.dispose();
  }

  void _formatToMoney() {
    final String text = widget.controller.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.isNotEmpty) {
      String formatted;
      if (widget.currency == 'Rp') {
        // Rupiah formatting: "Rp 1.000"
        final formatter = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp ',
          decimalDigits: 0,
        );
        formatted = formatter.format(int.parse(text));
      } else {
        // Generic currency formatting
        final formatter = NumberFormat.currency(
          locale: 'en_US',
          symbol: widget.currency,
          decimalDigits: 0,
        );
        formatted = formatter.format(int.parse(text));
      }

      widget.controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFilled = widget.controller.text.isNotEmpty;

    InputBorder borderStyle = widget.isBottomBorderOnly
        ? const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1),
    )
        : OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.grey, width: 1),
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: widget.enable,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Only allow numeric input
      ],
      validator: (value) {
        if (widget.isMandatory && (value == null || value.isEmpty)) {
          return 'This field is required.';
        }
        if (widget.validation != null) {
          return widget.validation!(value);
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.hint,
        labelStyle: TextStyle(
          color: _isFocused || isFilled ? Colors.black : Colors.grey,
          fontSize: 16,
          height: 1.5,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: !_isFocused && !isFilled ? widget.hint : null,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.white, // Set background color to white
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        suffixIcon: isFilled
            ? IconButton(
          icon: const Icon(Icons.clear, color: Colors.black87),
          onPressed: () {
            setState(() {
              widget.controller.clear();
            });
          },
        )
            : null,
        border: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: widget.isBottomBorderOnly
            ? const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black87, width: 2),
        )
            : OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black87, width: 2),
        ),
      ),
    );
  }
}
