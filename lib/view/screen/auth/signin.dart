import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../../../controller/auth/signincontroller.dart';
import '../../../core/class/handlingrequstveiw.dart';
import '../../../core/constanat/colors.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextformauth.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInContollerImp());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<SignInContollerImp>(
        builder: (contoller) {
          return CustomHandlingData(
            statusRequest: contoller.statusRequest,
            widget: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                SizedBox(height: 150.h),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "sign_in".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.greencolor,
                          fontSize: 25.sp,
                          fontFamily: "TejwalBold",
                        ),
                      ),
                      Text(
                        "sign_in_to_continue".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextFormAuth(
                      hinttext: "email".tr(),
                      mycontroller: contoller.email,
                      valid: (val) {
                        validInput("email", 10, 10, val!);
                        return null;
                      },
                      isNumber: false,
                      icons: Icon(Icons.person),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFormAuth(
                      hinttext: "password".tr(),
                      mycontroller: contoller.password,
                      valid: (val) {
                        validInput("password", 10, 10, val!);
                        return null;
                      },
                      isNumber: false,
                      obscureText: contoller.showPass,
                      icons: Icon(Icons.password),
                      onTapIcon: () {
                        contoller.showPassword();
                      },
                      iconData:
                          contoller.showPass
                              ? Icons.visibility
                              : Icons.visibility_off,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "did_you_forget_your_password".tr(),
                          style: TextStyle(color: AppColors.greencolor),
                        ),
                        TextButton(
                          onPressed: () {
                            contoller.gotoforgetpassword();
                          },
                          child: Text(
                            "click_here".tr(),
                            style: TextStyle(color: AppColors.orangecolor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "no_account".tr(),
                          style: TextStyle(color: AppColors.greencolor),
                        ),
                        TextButton(
                          onPressed: () {
                            contoller.gotosignup();
                          },
                          child: Text(
                            "click_here".tr(),
                            style: TextStyle(color: AppColors.orangecolor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomButton(
                  title: "sign_in".tr(),
                  onpress: () {
                    contoller.signin();
                  },
                ),
                TextButton(
                  onPressed: () {
                    contoller.continueAsGuest();
                  },
                  child: Text(
                    "continue_as_guest".tr(),
                    style: TextStyle(color: AppColors.greencolor),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          );
        },
      ),
    );
  }
}
