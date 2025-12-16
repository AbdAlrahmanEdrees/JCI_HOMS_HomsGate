import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/functions/validinput.dart';

import '../../../../controller/auth/forgetpassword/forgetpasswordcontroller.dart';
import '../../../../core/class/handlingrequstveiw.dart';
import '../../../../core/constanat/colors.dart';
import '../../../widget/auth/custombuttonauth.dart';
import '../../../widget/auth/customtextformauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controllerImp = Get.put(
      ForgetPasswordControllerImp(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text(
          "did_you_forget_your_password".tr(),
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body: GetBuilder<ForgetPasswordControllerImp>(
        builder: (controllerImp) {
          return HandlingDataRequest(
            statusRequest: controllerImp.statusRequest,
            widget: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Center(
                    child: Text(
                      "enter_your_email".tr(),
                      style: TextStyle(
                        color: AppColors.greencolor,
                        fontFamily: "Tejwal",
                        fontSize: 25,
                      ),
                    ),
                  ),
                  CustomTextFormAuth(
                    icons: Icon(Icons.email),
                    hinttext: "email".tr(),
                    mycontroller: controllerImp.email,
                    valid: (val) {
                      validInput("email", 3, 10, val!);
                      return null;
                    },
                    isNumber: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  CustomButton(
                    title: "confirm".tr(),
                    onpress: () {
                      controllerImp.ForgetPassword();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
