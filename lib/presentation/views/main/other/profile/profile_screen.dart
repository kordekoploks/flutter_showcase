import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/presentation/views/main/other/profile/profile_item_card.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../domain/entities/user/user.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../widgets/input_button.dart';
import '../../../../widgets/input_text_form_field.dart';
import '../../../../widgets/menu_item_card.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

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
    phoneNumber.text =widget.user.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: vWPrimaryColor,
      child: SizedBox(
        width: size.width,
        height: size.height * 0.30,
        child: Stack(
          children: [
            Column(
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
                    child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                      if (state is UserLogged) {
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height: 40,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: ProfileItemCard(
                                        onClick: () {
                                          Navigator.of(context).pushNamed(AppRouter.orders);
                                        },
                                        title: "First Name",
                                        data: state.user.firstName,
                                      ),
                                    ),Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: ProfileItemCard(
                                        onClick: () {
                                          Navigator.of(context).pushNamed(AppRouter.orders);
                                        },
                                        title: "Last Name",
                                        data: state.user.lastName,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: ProfileItemCard(
                                        onClick: () {
                                          Navigator.of(context).pushNamed(AppRouter.orders);
                                        },
                                        title: "Email",
                                        data: state.user.email,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: ProfileItemCard(
                                        onClick: () {
                                          Navigator.of(context).pushNamed(AppRouter.orders);
                                        },
                                        title: "Phone Number",
                                        data:  state.user.phoneNumber,
                                      ),
                                    ),
                                    SizedBox(height: 50,),
                                    VwButton(onClick:(){
                                      Navigator.of(context)
                                          .pushNamed(AppRouter.profileEditView,arguments: state.user);}, titleText: "Edit",)
                                  ]
                              ),
                            )
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if (state is UserLogged) {
                return Align(
                  alignment: const Alignment(0,-0.85),
                  child: Container(
                    width: size.width * 0.3,
                    height: size.height * 0.3,
                    child: SizedBox(
                      height: 80,
                      child: state.user.image != null
                          ? CachedNetworkImage(
                              imageUrl: state.user.image!,
                              imageBuilder: (context, image) => CircleAvatar(
                                radius: 36.0,
                                backgroundImage: image,
                                backgroundColor: Colors.white,
                              ),
                            )
                          :Image.asset(kUserAvatar),
                    ),
                  ),
                );
              } else
                return SizedBox();
            }),
            VwAppBar(title: "Profile"),
          ],
        ),
      ),
    );
  }
}
