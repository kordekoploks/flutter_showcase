// add_sub_category_bottom_sheet.dart
import 'package:eshop/data/models/category/outcome_sub_category_model.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:eshop/domain/usecases/outcome_sub_category/update_outcome_sub_category_usecase.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/util/UuidHelper.dart';
import '../../../../../data/models/income/income_sub_category_model.dart';
import '../../../../../domain/entities/category/income_category.dart';
import '../../../../../domain/usecases/income/update_income_sub_category_usecase.dart';
import '../../../../widgets/input_text_form_field.dart';

class SubCategoryIncomeAddBottomSheet extends StatefulWidget {
  final Function(IncomeSubCategoryUseCaseParams) onSave;
  final IncomeCategory categoryModel;

  SubCategoryIncomeAddBottomSheet(
      {super.key, required this.onSave, required this.categoryModel});

  @override
  _SubCategoryIncomeAddBottomSheetState createState() =>
      _SubCategoryIncomeAddBottomSheetState();
}

class _SubCategoryIncomeAddBottomSheetState
    extends State<SubCategoryIncomeAddBottomSheet> {
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
                    IncomeSubCategoryUseCaseParams(
                        incomeSubCategory: IncomeSubCategoryModel(
                          id: UuidHelper.generateNumericUUID(),
                          name: nameController.text,
                          desc: "${nameController.text} Description",
                        ), incomeCategory: widget.categoryModel)
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
