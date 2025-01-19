import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for inputFormatters

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
  final bool isNumericInput; // New property to enable numeric input

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
    this.isNumericInput = false, // Default is false
  }) : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  final _fieldKey = GlobalKey<FormFieldState>();
  bool _passwordVisible = false;

  double getFieldHeight() {
    if (_fieldKey.currentState?.hasError ?? false) {
      return widget.label != null ? 110 : 85;
    }
    return widget.label != null ? 85 : 60;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: getFieldHeight(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                widget.label!,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          Expanded(
            child: TextFormField(
              key: _fieldKey,
              controller: widget.controller,
              obscureText: widget.isSecureField && !_passwordVisible,
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
                  : TextInputType.text, // Set numeric keyboard type
              inputFormatters: widget.isNumericInput
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null, // Allow only numbers
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                fillColor: vWLightBackgroundColor,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon, color: Colors.black87)
                    : null,
                suffixIcon: widget.isSecureField
                    ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
