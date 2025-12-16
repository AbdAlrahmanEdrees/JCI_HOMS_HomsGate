import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:trip/core/constanat/colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../controller/onboardingcontoller.dart';

class CustomElevetedButtomOnBoarding extends GetView<OnBoardingControll> {
  const CustomElevetedButtomOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
        textColor: Colors.white,
        color: AppColors.greencolor,
        onPressed: () {
          controller.next();
        },
        child: Text("next".tr(), style: TextStyle(fontFamily: "Tejwal")),
      ),
    );
  }
}
