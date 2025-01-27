import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eshop/core/constant/colors.dart';

class InputTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validation;
  final double hintTextSize;
  final bool enable;
  final TextInputAction? textInputAction;
  final String? label;
  final IconData? prefixIcon;
  final Function(String)? onFieldSubmitted;
  final bool isMandatory;
  final bool isNumericInput;
  final bool isBottomBorderOnly; // New parameter for bottom border style

  const InputTextFormField({
    Key? key,
    required this.controller,
    this.isSecureField = false,
    this.autoCorrect = false,
    this.enable = true,
    this.hint,
    this.validation,
    this.contentPadding,
    this.textInputAction,
    this.hintTextSize = 14,
    this.onFieldSubmitted,
    this.label,
    this.prefixIcon,
    this.isMandatory = false,
    this.isNumericInput = false,
    this.isBottomBorderOnly = false, // Default is full border
  }) : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
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
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isFilled = widget.controller.text.isNotEmpty;

    InputBorder borderStyle = widget.isBottomBorderOnly
        ? UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1),
    )
        : OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.grey, width: 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.isSecureField,
          enableSuggestions: !widget.isSecureField,
          autocorrect: widget.autoCorrect,
          validator: (value) {
            if (widget.isMandatory && (value == null || value.isEmpty)) {
              return 'This field can\'t be empty';
            }
            if (widget.validation != null) {
              return widget.validation!(value);
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: widget.enable,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          keyboardType: widget.isNumericInput
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: widget.isNumericInput
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            labelText: widget.hint,
            labelStyle: TextStyle(
              color: _isFocused || isFilled ? Colors.black : Colors.grey,
              fontSize: 16,
              height: 1.5,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: !_isFocused && !isFilled ? widget.hint : null,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: widget.hintTextSize,
            ),
            filled: true,
            fillColor: vWLightBackgroundColor,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: Colors.black87)
                : null,
            suffixIcon: widget.isNumericInput && isFilled
                ? IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black87,
              ),
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
                ? UnderlineInputBorder(
              borderSide:
              const BorderSide(color: Colors.black87, width: 2),
            )
                : OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
              const BorderSide(color: Colors.black87, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

