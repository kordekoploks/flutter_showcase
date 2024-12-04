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
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/input_button.dart';
import '../../../../widgets/input_text_form_field.dart';
import '../../../../widgets/menu_item_card.dart';

class ProfileEditView extends StatefulWidget {
  final User user;

  const ProfileEditView({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    emailController.text = widget.user.email;
    phoneNumberController.text =widget.user.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
      EasyLoading.dismiss();
      if (state is UserLoading) {
        EasyLoading.show(status: 'Loading...');
      } else if (state is UserLogged) {

      } else if (state is UserLoggedFail) {
        EasyLoading.showError("Error");
      }
    },
    child: Container(
      color: vWPrimaryColor,
      child: SizedBox(
        width: size.width,
        height: size.height * 0.30,
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              BlocBuilder<UserBloc, UserState>(builder: (context, state) {
               if (state is UserLogged) {
                 return Column(
                    children: [
                      const Spacer(flex: 8),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.80,
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.04),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      Align(
                                        // alignment: const Alignment(0,-0.85),
                                        child: Container(
                                          width: 160,
                                          height: 100,
                                          child: SizedBox(
                                            height: 0,
                                            child: state.user.image != null
                                                ? CachedNetworkImage(
                                              imageUrl: state.user.image!,
                                              imageBuilder: (context, image) =>
                                                  CircleAvatar(
                                                    radius: 36.0,
                                                    backgroundImage: image,
                                                    backgroundColor: Colors.white,
                                                  ),
                                            )
                                                : Image.asset(kUserAvatar),
                                          ),
                                        ),

                                      ), SizedBox(height: 10,),
                                      InputTextFormField(
                                        controller: firstNameController,
                                        label: 'First Name',
                                        textInputAction: TextInputAction.next,
                                        isMandatory: true,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InputTextFormField(
                                        controller: lastNameController,
                                        label: 'Last Name',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InputTextFormField(
                                        controller: emailController,
                                        enable: false,
                                        label: 'Email Address',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ), InputTextFormField(
                                        controller: phoneNumberController,
                                        enable: false,
                                        label: 'Phone Number',
                                      ),

                                      SizedBox(
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .padding
                                            .bottom +
                                            50,
                                      ),
                                      VwButton(
                                        onClick: () {
                                          if (_formKey.currentState!.validate()) {
                                            // Extract only digits from the phone number input
                                            String phoneNumberText = phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

                                            // Validate if the resulting string is a valid phone number length (optional)
                                            if (phoneNumberText.length >= 10 && phoneNumberText.length <= 15) {
                                              context.read<UserBloc>().add(EditUser(
                                                EditParams(
                                                  firstName: firstNameController.text.trim(),
                                                  lastName: lastNameController.text.trim(),
                                                  phoneNumber: int.parse(phoneNumberText),
                                                  email: emailController.text.trim(),
                                                  password: passwordController.text,
                                                  id: state.user.id,
                                                ),
                                              ));
                                            } else {
                                              // Handle invalid phone number case (e.g., show a message to the user)
                                              print("Invalid phone number format.");
                                            }
                                          }

                                        },
                                        titleText: "Confirm x",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                else {return SizedBox();}
              }),

                VwAppBar(title: "Profile Edit"),
            ],
          ),
        ),
      ),
    ));
  }
}