import 'package:eshop/presentation/views/main/other/profile/bottomsheet/fullname_edit_bottom_sheet.dart';
import 'package:eshop/presentation/views/main/other/profile/profile_item_card.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../domain/entities/user/user.dart';

import '../../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../blocs/user/user_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  User user;

  UserProfileScreen({Key? key, required this.user}) : super(key: key);



  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}
String getInitials(String fullName) {
  List<String> nameParts = fullName.trim().split(' ');
  return nameParts.map((part) => part.isNotEmpty ? part[0].toUpperCase() : '').join();}

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
    String fullName = "John Doe";
    String initials = getInitials(fullName);
    super.initState();
  }

  void main() {
  }

  void _showSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(16.0),
        content: Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        duration: const Duration(seconds: 5),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.0),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: VwAppBar(
        title: "Profile",
        transparantMode: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 400,
                color: vWPrimaryColor,
                child:  Align(
                  alignment: Alignment.center,
                  child: Text(
                    getInitials(widget.user.firstName + " " + widget.user.lastName),
                    style: TextStyle(fontSize: 60, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Align(
                alignment: Alignment(0,0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 370),
                      height:290 ,
                      width: 360,
                      child: Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                title: AppLocalizations.of(context)!.fullName,
                                dataWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _showEditCategoryBottomSheet(context),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${widget.user.firstName} ${widget.user.lastName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          const Icon(Icons.edit, color: Colors.blue),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey, // You can customize the color
                                thickness: 1.0,    // Customize thickness
                                height: 20.0,      // Space around the divider
                              ),

                              SizedBox(height: 20,),
                              ProfileItemCard(
                                onClick: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.orders);
                                },
                                title: "Email",
                                data: widget.user.email,
                              ),
                              ProfileItemCard(
                                onClick: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.orders);
                                },
                                title: AppLocalizations.of(context)!.phoneNumber,
                                data: widget.user.phoneNumber,
                              ),const Divider(
                                color: Colors.grey, // You can customize the color
                                thickness: 1.0,    // Customize thickness
                                height: 20.0,      // Space around the divider
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    AppRouter.profileEditView,
                                    arguments: widget.user,
                                  );
                                },
                                child: Align(alignment: Alignment.bottomCenter,
                                  child: Text(
                                    AppLocalizations.of(context)!.seeProfileDetails,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue, // Customize the text color
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),),
                    SizedBox(height: 20,),
                    Container(
                      height:290 ,
                      width: 360,
                      child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                              title: AppLocalizations.of(context)!.fullName,
                              dataWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => _showEditCategoryBottomSheet(context),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${widget.user.firstName} ${widget.user.lastName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(Icons.edit, color: Colors.blue),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.grey, // You can customize the color
                              thickness: 1.0,    // Customize thickness
                              height: 20.0,      // Space around the divider
                            ),

                            SizedBox(height: 20,),
                            ProfileItemCard(
                              onClick: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.orders);
                              },
                              title: "Email",
                              data: widget.user.email,
                            ),
                            ProfileItemCard(
                              onClick: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.orders);
                              },
                              title: AppLocalizations.of(context)!.phoneNumber,
                              data: widget.user.phoneNumber,
                            ),const Divider(
                              color: Colors.grey, // You can customize the color
                              thickness: 1.0,    // Customize thickness
                              height: 20.0,      // Space around the divider
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AppRouter.profileEditView,
                                  arguments: widget.user,
                                );
                              },
                              child: Align(alignment: Alignment.bottomCenter,
                                child: Text(AppLocalizations.of(context)!.seeProfileDetails,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue, // Customize the text color
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),)
                  ],
                ),
              ),
            ],
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
