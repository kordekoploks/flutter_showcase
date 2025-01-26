import 'package:eshop/domain/entities/account/account_bottom_sheet/spinner_choose_group.dart';
import 'package:eshop/domain/entities/account/account_bottom_sheet/vw_spinner.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../presentation/widgets/input_text_form_field.dart';
import '../../../../presentation/widgets/vw_button.dart';

class AccountAddBottomSheet extends StatefulWidget {
  final Function(String, double, String, String) onSave;

  AccountAddBottomSheet({super.key, required this.onSave});

  @override
  _AccountAddBottomSheetState createState() => _AccountAddBottomSheetState();
}

class _AccountAddBottomSheetState extends State<AccountAddBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController initialAmountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedGroup = "Choose Group";
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    initialAmountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VWBottomSheet(
      title: "Add Account",
      content: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensure content doesn't overflow
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      insetPadding: EdgeInsets.all(8),
                      backgroundColor: Colors.transparent,
                      content: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SpinnerChooseGroup(
                          onClickGroup: (String accountGroup) {
                            setState(() {
                              selectedGroup = accountGroup;
                            });
                            Navigator.of(context).pop();
                          },
                          selectedGroup: selectedGroup,
                        ),
                      ),
                    ),
                  );
                },
                child: VwSpinner(
                  text: selectedGroup,
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
                controller: initialAmountController,
                textInputAction: TextInputAction.next,
                isMandatory: true,
                isNumericInput: true,
              ),
              SizedBox(height: 16),
              InputTextFormField(
                hint: "Description",
                controller: descriptionController,
                textInputAction: TextInputAction.next,
                isMandatory: true,
              ),
              SizedBox(height: 16),
              VwButton(
                onClick: () {
                  if (_formKey.currentState!.validate()) {
                    // Parse initialAmountController text to double
                    final double? initialAmount =
                    double.tryParse(initialAmountController.text);
                    if (initialAmount == null) {
                      // Show an error message if the value is not valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid initial amount.")),
                      );
                      return;
                    }
                    widget.onSave(
                      nameController.text,
                      initialAmount,
                      descriptionController.text,
                      selectedGroup,
                    );
                    Navigator.pop(context);
                  }
                },
                titleText: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
