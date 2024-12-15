import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/data/data_sources/local/user_local_data_source.dart';
import 'package:eshop/presentation/views/main/other/profile/bottomsheet/fullname_edit_bottom_sheet.dart';
import 'package:eshop/presentation/views/main/other/profile/profile_item_card.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../data/models/user/user_model.dart';
import '../../../../../domain/entities/user/user.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/input_button.dart';
import '../../../../widgets/input_text_form_field.dart';
import '../../../../widgets/menu_item_card.dart';
import '../../outcome_category/bottom_sheet/outcome_category_edit_bottom_sheet.dart';

class UserProfileScreen extends StatefulWidget {
  User user;

  UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    email.text = widget.user.email;
    phoneNumber.text = widget.user.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is UserEdited) {
          setState(() {
            widget.user =
                state.user; // Assuming state has an updatedUser property
            firstNameController.text = widget.user.firstName;
            lastNameController.text = widget.user.lastName;
            email.text = widget.user.email;
            phoneNumber.text = widget.user.phoneNumber.toString();
          });
          EasyLoading.showSuccess("Profile updated successfully!");
        } else if (state is UserEditFail) {
          EasyLoading.showError(state.failure.message);
        }
      },
      child: Scaffold(
        appBar: VwAppBar(
          title: "Profile",
          transparantMode: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: vWPrimaryColor,
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(0, -0.85),
                    child: Container(
                      width: size.width * 0.3,
                      height: size.width * 0.80, // Use width to avoid overflow
                      child: widget.user.image != null
                          ? CachedNetworkImage(
                              imageUrl: widget.user.image!,
                              imageBuilder: (context, image) => CircleAvatar(
                                radius: 36.0,
                                backgroundImage: image,
                                backgroundColor: Colors.white,
                              ),
                            )
                          : Image.asset(kUserAvatar),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            data: "",
                            title: "Full Name",
                            dataWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      _showEditCategoryBottomSheet(context),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${widget.user.firstName} ${widget.user.lastName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(Icons.edit,
                                          color: Colors.blue),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            title: "Email",
                            data: widget.user.email,
                          ),
                          ProfileItemCard(
                            onClick: () {
                              Navigator.of(context).pushNamed(AppRouter.orders);
                            },
                            title: "Phone Number",
                            data: widget.user.phoneNumber,
                          ),
                          const SizedBox(height: 50),
                          VwButton(
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                AppRouter.profileEditView,
                                arguments: widget.user,
                              );
                            },
                            titleText: "Edit",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FullNameEditBottomSheet(
          userModel: widget.user,
          onSave: (editUserParams) {
            context.read<UserBloc>().add(EditFullNameUser(editUserParams));
          },
        );
      },
    );
  }
}
