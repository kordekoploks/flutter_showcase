import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../domain/entities/user/user.dart';
import '../../../../../domain/usecases/user/edit_usecase.dart';
import '../../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/input_text_form_field.dart';

class ProfileEditView extends StatefulWidget {
  final User user;

  const ProfileEditView({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late User user;

  @override
  void initState() {
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    emailController.text = widget.user.email;
    phoneNumberController.text = widget.user.phoneNumber.toString();
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          EasyLoading.show(status: AppLocalizations.of(context)!.loading,);
        } else if (state is UserEdited) {
          EasyLoading.showSuccess(AppLocalizations.of(context)!.profileUpdatedSuccessfully);
        } else if (state is UserEditFail) {
          EasyLoading.showError(state.failure.message);
        }
      },
      child: Scaffold(
        appBar: VwAppBar(title: AppLocalizations.of(context)!.profileEdit),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
            color: vWPrimaryColor,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,54,0,120),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: widget.user.image != null
                            ? CachedNetworkImageProvider(widget.user.image!)
                            : const AssetImage(kUserAvatar) as ImageProvider,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.04),
                        child: Column(
                          children: [
                            InputTextFormField(
                              controller: firstNameController,
                              label: AppLocalizations.of(context)!.firstName,
                              textInputAction: TextInputAction.next,
                              isMandatory: true,
                            ),
                            const SizedBox(height: 20),
                            InputTextFormField(
                              controller: lastNameController,
                              label: AppLocalizations.of(context)!.lastName,
                            ),
                            const SizedBox(height: 20),
                            InputTextFormField(
                              controller: emailController,
                              enable: false,
                              label: 'Email',
                            ),
                            const SizedBox(height: 20),
                            InputTextFormField(
                              controller: phoneNumberController,
                              enable: false,
                              label: AppLocalizations.of(context)!.phoneNumber,
                            ),
                            const SizedBox(height: 20),
                            VwButton(
                              onClick: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<UserBloc>().add(
                                    EditUser(
                                      EditParams(
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        phoneNumber: int.parse(phoneNumberController.text),
                                        email: emailController.text.trim(),
                                        password: passwordController.text,
                                        id: user.id,
                                      ),
                                    ),
                                  );
                                }
                              },
                              titleText: AppLocalizations.of(context)!.confirm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
