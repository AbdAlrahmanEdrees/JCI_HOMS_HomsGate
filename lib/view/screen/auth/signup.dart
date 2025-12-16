import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../../../controller/auth/signup.dart';
import '../../../core/class/handlingrequstveiw.dart';
import '../../../core/constanat/colors.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextformauth.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpContollerImp());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<SignUpContollerImp>(
        builder:
            (contoller) => HandlingDataRequest(
              statusRequest: contoller.statusRequest,
              widget: ListView(
                padding: EdgeInsets.all(14),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  //logo
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "create_account".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greencolor,
                            fontSize: 25.sp,
                            fontFamily: "TejwalBold",
                          ),
                        ),
                        Text(
                          "create_account_to_continue".tr(),
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
                        hinttext: "first_name".tr(),
                        mycontroller: contoller.firstname,
                        valid: (val) {
                          validInput("username", 10, 10, val!);
                          return null;
                        },
                        isNumber: false,
                        icons: const Icon(Icons.person),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextFormAuth(
                        hinttext: "last_name".tr(),
                        mycontroller: contoller.lastname,
                        valid: (val) {
                          validInput("username", 10, 10, val!);
                          return null;
                        },
                        isNumber: false,
                        icons: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      CustomTextFormAuth(
                        hinttext: "email".tr(),
                        mycontroller: contoller.email,
                        valid: (val) {
                          validInput("email", 10, 10, val!);
                          return null;
                        },
                        isNumber: false,
                        icons: const Icon(Icons.email),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextFormAuth(
                        hinttext: "password".tr(),
                        mycontroller: contoller.password,
                        valid: (val) {
                          validInput("phone", 10, 10, val!);
                          return null;
                        },
                        isNumber: true,
                        icons: const Icon(Icons.phone),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextFormAuth(
                        hinttext: "confirm_password".tr(),
                        mycontroller: contoller.conipassword,
                        valid: (val) {
                          validInput("password", 10, 10, val!);
                          return null;
                        },
                        isNumber: false,
                        icons: const Icon(Icons.password),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  CustomButton(
                    title: "create_account".tr(),
                    onpress: () {
                      contoller.signUp();
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ],
              ),
            ),
      ),
    );
  }
}
