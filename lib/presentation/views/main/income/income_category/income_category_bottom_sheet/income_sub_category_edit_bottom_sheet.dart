import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/income/income_sub_category_model.dart';
import '../../../../../../domain/entities/category/income_category.dart';
import '../../../../../../domain/entities/category/income_sub_category.dart';
import '../../../../../../domain/usecases/income/update_income_sub_category_usecase.dart';
import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/vw_button.dart';

class IncomeSubCategoryEditBottomSheet extends StatefulWidget {
  final Function(IncomeSubCategoryUseCaseParams) onSave;
  final IncomeCategory incomeCategory;
  final IncomeSubCategory incomeSubCategory;

  IncomeSubCategoryEditBottomSheet({
    Key? key,
    required this.incomeSubCategory,
    required this.incomeCategory,
    required this.onSave,
  }) : super(key: key);

  @override
  _IncomeSubCategoryEditBottomSheetState createState() =>
      _IncomeSubCategoryEditBottomSheetState();
}

class _IncomeSubCategoryEditBottomSheetState
    extends State<IncomeSubCategoryEditBottomSheet> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.incomeSubCategory.name);
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
                widget.onSave(IncomeSubCategoryUseCaseParams(
                    incomeSubCategory: IncomeSubCategoryModel(
                      id: widget.incomeSubCategory.id,
                      name: nameController.text,
                      desc: widget.incomeSubCategory.desc,
                    ),
                    incomeCategory: widget.incomeCategory));
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
