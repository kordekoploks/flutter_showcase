import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/input_text_form_field.dart';
import '../../../../widgets/vw_button.dart';


class CategoryEditBottomSheet extends StatefulWidget {
  final Function(OutcomeCategoryModel) onSave;
  final OutcomeCategory category;

  CategoryEditBottomSheet({
    Key? key,
    required this.category,
    required this.onSave,
  }) : super(key: key);

  @override
  _CategoryEditBottomSheetState createState() => _CategoryEditBottomSheetState();
}

class _CategoryEditBottomSheetState extends State<CategoryEditBottomSheet> {
  late TextEditingController nameController;

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
                  OutcomeCategoryModel(
                    id: widget.category.id,
                    position: widget.category.position,
                    name: nameController.text,
                    desc: widget.category.desc,
                    image: widget.category.image,
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
}
