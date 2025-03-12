import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/category/income_category_model.dart';
import '../../../../../../domain/entities/category/income_category.dart';
import '../../../../../../domain/entities/image/IconSelection.dart';
import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/vw_button.dart';
import 'icon_helper.dart';
import 'icon_selection_bottom_sheet.dart';


class IncomeCategoryEditBottomSheet extends StatefulWidget {
  final Function(IncomeCategoryModel) onSave;
  final IncomeCategory category;

  IncomeCategoryEditBottomSheet({
    Key? key,
    required this.category,
    required this.onSave,
  }) : super(key: key);

  @override
  _IncomeCategoryEditBottomSheetState createState() => _IncomeCategoryEditBottomSheetState();
}

class _IncomeCategoryEditBottomSheetState extends State<IncomeCategoryEditBottomSheet> {
  late TextEditingController nameController;
  IconSelection selectedIcon = IconHelper.defaultIcon;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Edit Category",
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputTextFormField(
              label: "Nama Kategori",
              controller: nameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,

            ),
            SizedBox(height: 16),
            VwButton(
              onClick: () {
                widget.onSave(
                  IncomeCategoryModel(
                    id: widget.category.id,
                    position: widget.category.position,
                    name: nameController.text,
                    desc: widget.category.desc,
                    image: widget.category.image,
                    icon: widget.category.icon,
                  ),
                );
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
