import 'package:eshop/data/models/category/category_model.dart';
import 'package:eshop/domain/entities/category/category.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/input_text_form_field.dart';

class ConfirmationBottomSheet extends StatefulWidget {
  final String title;
  final Widget desc;
  final Function()? onPositiveClick;
  final String positiveLabel;
  final Function()? onNegativeClick;
  final String negativeLabel;
  final bool isReverted;

  ConfirmationBottomSheet({
    Key? key,
    required this.title, required this.desc, this.onPositiveClick, this.onNegativeClick, required this.positiveLabel, required this.negativeLabel, this.isReverted = false
  }) : super(key: key);

  @override
  _ConfirmationBottomSheetState createState() =>
      _ConfirmationBottomSheetState();
}

class _ConfirmationBottomSheetState extends State<ConfirmationBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: widget.title,
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.desc,
            SizedBox(height: 16),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                   widget.onPositiveClick;
                    Navigator.pop(context);
                  },
                  child: Text(widget.positiveLabel),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onNegativeClick;
                    Navigator.pop(context);
                  },
                  child: Text(widget.negativeLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context, {bool reversed = false}) {
    final positiveButton = ElevatedButton(
      onPressed: () {
        widget.onPositiveClick?.call();
        Navigator.pop(context);
      },
      child: Text(widget.positiveLabel),
    );

    final negativeButton = ElevatedButton(
      onPressed: () {
        widget.onNegativeClick?.call();
        Navigator.pop(context);
      },
      child: Text(widget.negativeLabel),
    );

    return reversed
        ? [negativeButton, SizedBox(width: 8), positiveButton]
        : [positiveButton, SizedBox(width: 8), negativeButton];
  }
}
