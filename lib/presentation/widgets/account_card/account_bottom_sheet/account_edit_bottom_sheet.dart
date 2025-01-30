import 'package:flutter/material.dart';

import '../../../../data/models/account/account_model.dart';
import '../../../../domain/entities/account/account.dart';
import '../../../../domain/entities/account/account_bottom_sheet/spinner_choose_group.dart';
import '../../../../domain/entities/account/account_bottom_sheet/vw_spinner.dart';
import '../../input_text_form_field.dart';
import '../../vw_bottom_sheet.dart';
import '../../vw_button.dart';

class AccountEditBottomSheet extends StatefulWidget {
  final Function(AccountModel) onSave; // Adjusted function signature
  final Account account;

  const AccountEditBottomSheet({
    Key? key,
    required this.account,
    required this.onSave,
  }) : super(key: key);

  @override
  _AccountEditBottomSheetState createState() => _AccountEditBottomSheetState();
}

class _AccountEditBottomSheetState extends State<AccountEditBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController initialAmountController;
  late TextEditingController descriptionController;
  String selectedGroup = "Choose Group";
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.account.name);
    initialAmountController =
        TextEditingController(text: widget.account.initialAmt.toString());
    descriptionController = TextEditingController(text: widget.account.desc);
    selectedGroup = widget.account.accountGroup;
  }

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
      title: "Edit Account",
      content: Padding(
        padding: const EdgeInsets.all(16.0),
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
              //   child: Container(
              //     height: 60,
              //     width: double.infinity, // Use responsive width
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(color: Colors.grey),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 16.0, vertical: 16.0),
              //       child: Text(
              //         selectedGroup,
              //         style: TextStyle(color: Colors.grey, fontSize: 16),
              //       ),
              //     ),
              // ),
              SizedBox(
                height: 16,
              ),
              InputTextFormField(
                hint: "Account Name",
                controller: nameController,
                textInputAction: TextInputAction.next,
                isMandatory: true,
              ),
              const SizedBox(height: 16),
              InputTextFormField(
                hint: "Initial Amount",
                controller: initialAmountController,
                textInputAction: TextInputAction.next,
                isMandatory: true,
                isNumericInput: true,
              ),
              const SizedBox(height: 16),
              InputTextFormField(
                hint: "Description",
                controller: descriptionController,
                textInputAction: TextInputAction.done,
                isMandatory: true,
              ),
              const SizedBox(height: 16),
              VwButton(
                onClick: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(
                      AccountModel(
                        id: widget.account.id,
                        name: nameController.text,
                        desc: descriptionController.text,
                        initialAmt:
                        double.tryParse(initialAmountController.text) ?? 0.0,
                        accountGroup: selectedGroup,
                      ),
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
