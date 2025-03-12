import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/entities/image/IconSelection.dart';
import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/vw_button.dart';
import 'icon_helper.dart';
import 'icon_selection_bottom_sheet.dart';


class IncomeCategoryAddBottomSheet extends StatefulWidget {
  final Function(String,String) onSave;

  IncomeCategoryAddBottomSheet({super.key, required this.onSave});

  @override
  _IncomeCategoryAddBottomSheetState createState() => _IncomeCategoryAddBottomSheetState();
}

class _IncomeCategoryAddBottomSheetState extends State<IncomeCategoryAddBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  IconSelection selectedIcon = IconHelper.defaultIcon;
  

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
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
              hint: "Nama Kategori",
              controller: nameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,
            ),
        SizedBox(height: 16),
        InputTextFormField(
          hint: "Deskripsi",
          controller: descriptionController,
          textInputAction: TextInputAction.next,
          isMandatory: true,
        ),
            SizedBox(height: 16),
            VwButton(
              onClick: () {_showIconSelectionBottomSheet(context);
              },
              titleText: 'Pilih Gambar',
            ),
            SizedBox(height: 16),
            Icon(selectedIcon.icon),
            VwButton(
              onClick: () {
                widget.onSave(nameController.text,descriptionController.text);
                Navigator.pop(context);
              },
              titleText: 'Simpan',
            ),
          ],
        ),
      ),
    );
  }
  

  void _showIconSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IconSelectionBottomSheet(
          defaultIcon: selectedIcon,
          onIconSelection: (val) {
            setState(() {
              selectedIcon = val;
            });
          },
        );
      },
    );
  }

}
