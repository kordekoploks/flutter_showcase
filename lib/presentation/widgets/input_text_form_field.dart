import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

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
    this.prefixIcon
  }) : super(key: key);

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,

      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isSecureField && !_passwordVisible,
        enableSuggestions: !widget.isSecureField,
        autocorrect: widget.autoCorrect,
        validator: widget.validation,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: widget.enable,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          filled: true,
          label: widget.label !=null ? Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              widget.label!,
              style: TextStyle(color: vWInputLabelColor,fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ) : null,
          contentPadding: const EdgeInsets.fromLTRB(12,16,12,0),
          fillColor: vWInputBackgroundColor,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon:  widget.prefixIcon!=null ? Icon(widget.prefixIcon,color: Colors.black87):null ,
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
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
