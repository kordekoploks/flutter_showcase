import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';

class VwCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  VwCheckbox({required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<VwCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  void _handleTap() {
    setState(() {
      _isChecked = !_isChecked;
      widget.onChanged(_isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: _isChecked ? vWPrimaryColor : Colors.transparent,
          border: Border.all(color: vWPrimaryColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: _isChecked
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 18.0,
              )
            : null,
      ),
    );
  }
}
