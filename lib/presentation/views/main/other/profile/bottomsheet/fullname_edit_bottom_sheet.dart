
import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/user/user_model.dart';
import '../../../../../../domain/entities/user/user.dart';
import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/vw_button.dart';



class FullNameEditBottomSheet extends StatefulWidget {
  final Function(EditFullNameParams) onSave;
  final User userModel;

  FullNameEditBottomSheet({
    Key? key,
    required this.userModel,
    required this.onSave,
  }) : super(key: key);

  @override
  _FullNameEditBottomSheetState createState() => _FullNameEditBottomSheetState();
}

class _FullNameEditBottomSheetState extends State<FullNameEditBottomSheet> {
  late TextEditingController FirstnameController;
  late TextEditingController LastnameController;

  @override
  void initState() {
    super.initState();
    FirstnameController = TextEditingController(text: widget.userModel.firstName);
    LastnameController = TextEditingController(text: widget.userModel.lastName);
  }

  @override
  void dispose() {
    FirstnameController.dispose();
    LastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Edit FullName",
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputTextFormField(
              label: "Nama Kategori",
              controller: FirstnameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,

            ),
            InputTextFormField(
              label: "Nama Kategori",
              controller: LastnameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,

            ),
            SizedBox(height: 16),
            VwButton(
              onClick: () {
                widget.onSave(
                  EditFullNameParams(
                    id: widget.userModel.id,
                   firstName: FirstnameController.text,
                    lastName: LastnameController.text,
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
