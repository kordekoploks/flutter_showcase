// add_sub_category_bottom_sheet.dart
import 'package:eshop/data/models/category/outcome_sub_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/UuidHelper.dart';
import '../../../widgets/input_text_form_field.dart';

class OutcomeSubCategoryAddBottomSheet extends StatefulWidget {
  final Function(OutcomeSubCategoryUseCaseParams) onSave;
  final OutcomeCategory categoryModel;

  OutcomeSubCategoryAddBottomSheet(
      {super.key, required this.onSave, required this.categoryModel});

  @override
  _OutcomeSubCategoryAddBottomSheetState createState() =>
      _OutcomeSubCategoryAddBottomSheetState();
}

class _OutcomeSubCategoryAddBottomSheetState
    extends State<OutcomeSubCategoryAddBottomSheet> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Tambah Sub Kategori",
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
                widget.onSave(
                  OutcomeSubCategoryUseCaseParams(
                      outcomeSubCategory: OutcomeSubCategoryModel(
                        id: UuidHelper.generateNumericUUID(),
                        name: nameController.text,
                        desc: "${nameController.text} Description",
                      ), outcomeCategory: widget.categoryModel)
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
