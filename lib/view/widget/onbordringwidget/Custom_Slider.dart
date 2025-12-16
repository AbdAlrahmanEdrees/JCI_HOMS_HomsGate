import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import '../../../controller/onboardingcontoller.dart';
import '../../../data/static/onbordring.dart';

class CustomSliderOnBordring extends GetView<OnBoardingControll> {
  const CustomSliderOnBordring({super.key, Key? k});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val) {
        controller.onpagechange(val);
      },
      itemCount: data.length,
      itemBuilder: (context, i) {
        return Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  data[i].imageurl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Positioned(
              top: 350.sp,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  children: [
                    Text(
                      data[i].title.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Tejwal",
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      data[i].subtitle.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontFamily: "Tejwal",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
