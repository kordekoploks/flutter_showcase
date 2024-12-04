import 'package:eshop/core/constant/colors.dart';
import 'package:eshop/core/constant/images.dart';
import 'package:eshop/presentation/widgets/vw_appbar.dart';
import 'package:eshop/presentation/widgets/vw_button.dart';
import 'package:flutter/material.dart';

class ChangePassword2 extends StatelessWidget {
  const ChangePassword2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VwAppBar(title: ""),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset(cPsuccess),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Change password successfully!",
                  style: TextStyle(color: vWPrimaryColor, fontSize: 16),
                )),
                SizedBox(
                  height: 20,
                ),
                Text("You have successfully change password",
                    style: TextStyle(fontSize: 14)),
                Text("Please use the new password when Sign in.",
                    style: TextStyle(fontSize: 14)),
                SizedBox(
                  height: 30,
                ),
                VwButton(onClick: () {}, titleText: "Change Password"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
