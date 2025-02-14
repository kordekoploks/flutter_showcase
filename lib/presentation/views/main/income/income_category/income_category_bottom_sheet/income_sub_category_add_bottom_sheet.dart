import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/vw_button.dart';

class IncomeSubCategoryAddBottomSheet extends StatefulWidget {
  final Function(String) onSave;

  IncomeSubCategoryAddBottomSheet({super.key, required this.onSave});

  @override
  _IncomeSubCategoryAddBottomSheetState createState() => _IncomeSubCategoryAddBottomSheetState();
}

class _IncomeSubCategoryAddBottomSheetState extends State<IncomeSubCategoryAddBottomSheet> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Tambah Sub Category",
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            InputTextFormField(
              label: "Nama Sub Kategori",
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
