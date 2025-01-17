import 'package:eshop/domain/entities/account/account_bottom_sheet/spinner_choose_group.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../presentation/widgets/input_text_form_field.dart';
import '../../../../presentation/widgets/vw_button.dart';

class AccountAddBottomSheet extends StatefulWidget {
  final Function(String) onSave;

  AccountAddBottomSheet({super.key, required this.onSave});

  @override
  _AccountAddBottomSheetState createState() => _AccountAddBottomSheetState();
}

class _AccountAddBottomSheetState extends State<AccountAddBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  String selectedGroup = "Choose Group"; // Initialize with default text

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Add Account",
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 0),
            GestureDetector(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SpinnerChooseGroup(
                      onClickGroup: (String accountGroup) {
                        // Update the selected group text when a group is chosen
                        setState(() {
                          selectedGroup = accountGroup;
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                width: 360,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Text(
                    selectedGroup, // Display the updated group
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            InputTextFormField(
              hint: "Name",
              controller: nameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,
            ),
            SizedBox(height: 16),
            InputTextFormField(
              hint: "Initial Amount",
              controller: nameController,
              textInputAction: TextInputAction.next,
              isMandatory: true,
            ),
            SizedBox(height: 16),
            InputTextFormField(
              hint: "Description",
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
