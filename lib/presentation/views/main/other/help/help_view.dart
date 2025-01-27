import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/widgets/help_card.dart';
import 'package:eshop/presentation/widgets/menu_item_card.dart';
import 'package:flutter/material.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/constant/images.dart';
import '../../../../blocs/user/user_bloc.dart';

// Helper function to get initials from a full name.
String getInitials(String fullName) {
  return fullName
      .trim()
      .split(' ')
      .map((part) => part.isNotEmpty ? part[0].toUpperCase() : '')
      .join();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: HelpView(),
    );
  }
}

class HelpView extends StatefulWidget {
  HelpView({Key? key}) : super(key: key);

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  int _selectedIndex = 0; // Tracks the currently selected tab.

  // Titles for the tabs.
  final List<String> _tabTitles = ["Contact Us", "FAQ"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(
        title: "Help",
        transparantMode: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom TabBar
            VwTabBar(
              titles: _tabTitles,
              selectedIndex: _selectedIndex,
              onTabTapped: (index) {
                setState(() {
                  _selectedIndex = index; // Update the selected tab index.
                });
              },
            ),

            // Display content based on the selected tab.
            // Expanded(
            //   child: Center(
            //     child: Text(
            //       "Selected Tab: ${_tabTitles[_selectedIndex]}",
            //       style: TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 16,
            ),
            Image.asset(
              kSignUp,
              height: 230,
              width: 230,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Ready 24/7 to help you",
              style: TextStyle(color: vWPrimaryColor, fontSize: 20),
            ),
            SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hi, ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLogged) {
                        return Text(
                          '${state.user.firstName} ${state.user.lastName}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
                Text(
                  " feel free to reach us",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Anytime from one of channels below",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.call,color: Colors.grey,
                        size: 30,
                      ),
                      Text(
                        "Call",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                    ],
                  ),
                  VerticalDivider(thickness: 1,color: Colors.grey,),
                  Column(
                    children: [
                      Icon(
                        Icons.chat,color: Colors.grey,
                        size: 30,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                    ],
                  ),
                  VerticalDivider(thickness: 1,color: Colors.grey,),
                  Column(
                    children: [
                      Icon(
                        Icons.email,color: Colors.grey,
                        size: 30,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Divider(
              height: 20,thickness: 2,color: Colors.black12,
            ),
            HelpCard(
              onClick: (){},
              title: "Exchnge Rates & Simulation",
              text: "View exchange rates and simulatie",
              text2: "Buying or selling foreign currency",
            ),
            HelpCard(
              onClick: (){},
              title: "Term & Conditions",
              text: "View exchange rates and simulatie",
              text2: "Buying or selling foreign currency",
            ),
          ],
        ),
      ),
    );
  }
}
