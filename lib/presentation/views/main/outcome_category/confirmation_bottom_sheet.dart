import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
    required this.title, required this.desc, this.onPositiveClick, this.onNegativeClick, this.positiveLabel = "Ya",  this.negativeLabel = "Tidak", this.isReverted = false
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
              children: widget.isReverted
                  ? _buildButtons(context, reversed: true)
                  : _buildButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context, {bool reversed = false}) {
    final positiveButton = Expanded(
      child: VwButton(
        onClick: () {
          widget.onPositiveClick?.call();
          Navigator.pop(context);
        },
        titleText: widget.positiveLabel,
        buttonType: ButtonType.primary,
      ),
    );

    final negativeButton = Expanded(
      child: VwButton(
        onClick: () {
          widget.onNegativeClick?.call();
          Navigator.pop(context);
        },
        titleText: widget.negativeLabel,
        buttonType: ButtonType.secondary,
      ),
    );

    return reversed
        ? [negativeButton, SizedBox(width: 8), positiveButton]
        : [positiveButton, SizedBox(width: 8), negativeButton];
  }


}
