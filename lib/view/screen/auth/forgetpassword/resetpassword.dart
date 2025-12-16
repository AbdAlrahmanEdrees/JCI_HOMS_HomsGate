import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../../../../controller/auth/forgetpassword/resetpassword.dart';
import '../../../../core/class/handlingrequstveiw.dart';
import '../../../../core/constanat/colors.dart';
import '../../../../core/functions/validinput.dart';
import '../../../widget/auth/customtextformauth.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordControllerImp controller = ResetPasswordControllerImp();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text(
          "reset_password".tr(),
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body:GetBuilder<ResetPasswordControllerImp>(
        builder: (controller){
          return HandlingDataRequest(statusRequest: controller.statusRequest, widget:  ListView(
            padding: EdgeInsets.all(25.sp),
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "enter_new_password".tr(),
                      style: TextStyle(
                          color: AppColors.greencolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: "Tejwal"),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.sp,
              ),
              CustomTextFormAuth(
                  icons: Icon(Icons.person),
                  hinttext: "confirm_password".tr(),
                  mycontroller: controller.newpassword,
                  valid: (val) {
                    validInput("email", 5, 25, val!);
                    return null;
                  },
                  isNumber: false)
            ],
          ));
        },
      )
    );
  }
}
