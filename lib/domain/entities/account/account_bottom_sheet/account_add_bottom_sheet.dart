import 'package:eshop/core/util/money_text_controller.dart';
import 'package:eshop/domain/entities/account/account_bottom_sheet/spinner_choose_group.dart';
import 'package:eshop/domain/entities/account/account_bottom_sheet/vw_spinner.dart';
import 'package:eshop/presentation/widgets/input_money_form_field.dart';
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
  final MoneyTextController initialAmountController = MoneyTextController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedGroup = "Choose Group";
  bool isValid = true;
  bool isAmountValid = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    initialAmountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool validate() {
    setState(() {
      isValid = selectedGroup != "Choose Group";
      isAmountValid = initialAmountController.parsedValue != null;
    });
    return isValid && isAmountValid;
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
            mainAxisSize: MainAxisSize.min,
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
                              isValid = true;
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
                  isValid: isValid,
                  placeholder: "Choose Group",
                  label: "Group",
                  validationMessage: "Please choose a group",
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
              InputMoneyFormField(
                hint: "Initial Amount",
                controller: initialAmountController,
                isMandatory: true,
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
                  validate();
                  if (_formKey.currentState!.validate() && validate()) {
                    final double initialAmount = initialAmountController.parsedValue;
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
