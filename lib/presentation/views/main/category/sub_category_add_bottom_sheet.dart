// add_sub_category_bottom_sheet.dart
import 'package:eshop/domain/entities/category/category.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/input_text_form_field.dart';

class SubCategoryAddBottomSheet extends VWBottomSheet {
  final Category categoryModel;
  final VoidCallback onSave;

  SubCategoryAddBottomSheet({
    required this.categoryModel,
    required this.onSave,
  }) : super(
    title: "Tambah Sub Category",
    content: Padding(
      padding: const EdgeInsets.all(0),
      child: Builder(
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                categoryModel.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),


              SizedBox(height: 16),
              InputTextFormField(
                label: "Nama Sub Kategori",
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                isMandatory: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  onSave();
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      ),
    ),
  );

}

