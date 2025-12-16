import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import '../../widget/onbordringwidget/CustomElevetedButtom.dart';
import '../../widget/onbordringwidget/Custom_Dotet.dart';
import '../../widget/onbordringwidget/Custom_Slider.dart';
import '../../../controller/onboardingcontoller.dart';

class OnBoardringScreen extends StatelessWidget {
  OnBoardringScreen({super.key, Key? k});
  final pref = Get.find<SharedPreferencesService>();
  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControll());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 3.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (Get.locale == Locale('en')) {
                        await context.setLocale(Locale('ar'));
                        Get.updateLocale(Locale('ar'));
                        pref.setLanguage('ar');
                      } else {
                        await context.setLocale(Locale('en'));
                        Get.updateLocale(Locale('en'));
                        pref.setLanguage('en');
                      }
                    },
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language_outlined),
                          SizedBox(width: 3.w),
                          Text("language".tr()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Expanded(flex: 3, child: CustomSliderOnBordring()),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomDotet(),
                    SizedBox(height: 20), // Adjusted the SizedBox height
                    CustomElevetedButtomOnBoarding(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
