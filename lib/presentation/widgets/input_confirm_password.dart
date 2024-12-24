import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

class InputConfirmPassword extends StatefulWidget {
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
  final bool isMandatory; // New parameter to mark the field as optional

  const InputConfirmPassword({
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
    this.isMandatory = false, // Default value for the new parameter
  }) : super(key: key);

  @override
  State<InputConfirmPassword> createState() => _InputConfirmPasswordState();
}

class _InputConfirmPasswordState extends State<InputConfirmPassword> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: SizedBox(
        height: 5.0,
        width: double.infinity,
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isSecureField && !_passwordVisible,
          enableSuggestions: !widget.isSecureField,
          autocorrect: widget.autoCorrect,
          validator: (value) {
            if (widget.isMandatory && (value == null || value.isEmpty)) {
              return 'This field can\'t be empty'; // If the field is optional and empty, return null
            }
            if (widget.validation != null) {
              return widget.validation!(value); // Apply the provided validation logic
            }
            return null; // Default return null if no validation logic is provided
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: widget.enable,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            filled: true,
            label: widget.label != null
                ? Padding(
              padding: const EdgeInsets.only(bottom:0),
              child: Text(
                widget.label!,
                style: TextStyle(color: vWInputLabelColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
                : null,
            contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            fillColor: vWLightBackgroundColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.black87) : null,
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
    );
  }
}
