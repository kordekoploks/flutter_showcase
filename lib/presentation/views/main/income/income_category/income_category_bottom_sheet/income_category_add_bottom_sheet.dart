import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/vw_button.dart';


class IncomeCategoryAddBottomSheet extends StatefulWidget {
  final Function(String) onSave;

  IncomeCategoryAddBottomSheet({super.key, required this.onSave});

  @override
  _IncomeCategoryAddBottomSheetState createState() => _IncomeCategoryAddBottomSheetState();
}

class _IncomeCategoryAddBottomSheetState extends State<IncomeCategoryAddBottomSheet> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Tambah Category",
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            InputTextFormField(
              label: "Nama Kategori",
              controller: nameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,
            ),
            SizedBox(height: 16),
            VwButton(
              onClick: () {
                widget.onSave(nameController.text);
                Navigator.pop(context);
              },
              titleText: 'Simpan',
            ),
          ],
        ),
      ),
    );
  }
}
