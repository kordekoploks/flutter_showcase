import 'package:flutter/material.dart';

class VwSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final String hintText;
  final bool showClearButton; // Parameter to control clear button visibility

  const VwSearchTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    this.hintText = "Search", // Default hint text
    this.showClearButton = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: false,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, bottom: 22, top: 22),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.search),
        ),
        suffixIcon: (showClearButton && controller.text.isNotEmpty)
            ? Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              controller.clear();
              onChanged('');
            },
            icon: const Icon(Icons.clear),
          ),
        )
            : null,
        border: const OutlineInputBorder(),
        hintText: hintText,
        fillColor: Colors.grey.shade100,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.circular(26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
          borderSide: const BorderSide(color: Colors.white, width: 3.0),
        ),
      ),
    );
  }
}
