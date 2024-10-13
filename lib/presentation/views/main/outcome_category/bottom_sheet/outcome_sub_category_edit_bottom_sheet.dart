import 'package:eshop/data/models/category/outcome_category_model.dart';
import 'package:eshop/data/models/category/outcome_sub_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/entities/category/outcome_sub_category.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/input_text_form_field.dart';
import '../../../../widgets/vw_button.dart';

class OutcomeSubCategoryEditBottomSheet extends StatefulWidget {
  final Function(OutcomeSubCategoryUseCaseParams) onSave;
  final OutcomeCategory outcomeCategory;
  final OutcomeSubCategory outcomeSubCategory;

  OutcomeSubCategoryEditBottomSheet({
    Key? key,
    required this.outcomeSubCategory,
    required this.outcomeCategory,
    required this.onSave,
  }) : super(key: key);

  @override
  _OutcomeSubCategoryEditBottomSheetState createState() =>
      _OutcomeSubCategoryEditBottomSheetState();
}

class _OutcomeSubCategoryEditBottomSheetState
    extends State<OutcomeSubCategoryEditBottomSheet> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.outcomeSubCategory.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Edit Sub Category",
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputTextFormField(
              label: "Nama Sub Kategori",
              controller: nameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,
            ),
            SizedBox(height: 16),
            VwButton(
              onClick: () {
                widget.onSave(OutcomeSubCategoryUseCaseParams(
                    outcomeSubCategory: OutcomeSubCategoryModel(
                      id: widget.outcomeSubCategory.id,
                      name: nameController.text,
                      desc: widget.outcomeSubCategory.desc,
                    ),
                    outcomeCategory: widget.outcomeCategory));
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
