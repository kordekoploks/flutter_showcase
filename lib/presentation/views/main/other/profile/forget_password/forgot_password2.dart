import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/router/app_router.dart';
import '../../../../../widgets/vw_appbar.dart';

class ForgotPassword2 extends StatelessWidget {
  const ForgotPassword2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: "Forgot Password"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 380,
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
                      "Type a code",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Code",
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: vWPrimaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 27, vertical: 17),
                            // Increase padding
                            minimumSize: Size(100,
                                50), // Set minimum size for width and height
                          ),
                          child: Text(
                            "Resend",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight
                                    .bold), // Adjust font size if needed
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      "We texted you a code to verify your ",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Text(
                          "phone number",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          "(+84) 0398829xxx",
                          style:
                              TextStyle(fontSize: 15, color: Colors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      "This code will expire 10 minutes after this message. If you don't get a message.",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    VwButton(
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(AppRouter.changePassword);
                        },
                        titleText: "Change Password"),
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
