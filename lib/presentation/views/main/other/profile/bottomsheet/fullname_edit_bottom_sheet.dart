import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';
import 'package:eshop/presentation/widgets/vw_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../data/models/user/user_model.dart';
import '../../../../../../domain/entities/user/user.dart';
import '../../../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../../blocs/user/user_bloc.dart';
import '../../../../../widgets/input_text_form_field.dart';
import '../../../../../widgets/product_card.dart';
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
  _FullNameEditBottomSheetState createState() =>
      _FullNameEditBottomSheetState();
}

class _FullNameEditBottomSheetState extends State<FullNameEditBottomSheet> {
  late TextEditingController FirstnameController;
  late TextEditingController LastnameController;

  @override
  void initState() {
    super.initState();
    FirstnameController =
        TextEditingController(text: widget.userModel.firstName);
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
      title:  AppLocalizations.of(context)!.editFullName,
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoading) {
            // Show shimmer loading effect
            return SizedBox(
              width: double.infinity,
              height: 200,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.white,
                child: const ProductCard(),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTextFormField(
                  label:  AppLocalizations.of(context)!.firstName,
                  controller: FirstnameController,
                  textInputAction: TextInputAction.next,
                  isMandatory: true,
                ),SizedBox(height: 16,),
                InputTextFormField(
                  label:  AppLocalizations.of(context)!.lastName,
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
                  },
                  titleText:  AppLocalizations.of(context)!.save,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
