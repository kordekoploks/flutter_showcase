import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../widgets/vw_appbar.dart';

class ForgotPassword1 extends StatelessWidget {
  const ForgotPassword1({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: "Forgot Password"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 330,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type your Phone Number",
                      style: TextStyle(color: Colors.black26, fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "(+62)",
                            hintStyle: TextStyle(color: Colors.black26),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "We texted you a code to verify your phone number",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(

                      child: VwButton(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(AppRouter.forgotPassword2);
                          },
                          titleText: "Send"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
