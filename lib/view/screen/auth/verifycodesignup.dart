import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../../../controller/auth/verifycodesignupcontroller.dart';
import '../../../core/constanat/colors.dart';

class VerifyCodeSignup extends StatelessWidget {
  const VerifyCodeSignup({super.key});

  @override
  Widget build(BuildContext context) {
    VerifyCodeSignUpcontollerImp controller=Get.put(VerifyCodeSignUpcontollerImp());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text(
          "confirm_your_email".tr(),
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Center(
            child: Column(
              children: [
                Text(
                  "you_are_one_step_before_starting".tr(),
                  style: TextStyle(
                      color: AppColors.greencolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "Tejwal"),
                ),
                Text("you_are_one_step_before_starting".tr(),style: TextStyle(color: Colors.grey,fontSize: 18),)
              ],
            ),
          ),
          SizedBox(
            height: 25.sp,
          ),
          OtpTextField(
            borderRadius: BorderRadius.circular(15),
            numberOfFields: 6,
            borderColor:const Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              controller.verifyaccound(verificationCode);
            }, // end onSubmit
          ),
        ],
      ),
    );
  }
}
