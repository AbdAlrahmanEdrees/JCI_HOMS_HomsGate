import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/customize_search_controller.dart';

import '../../core/constanat/colors.dart';

class CustomizeSearch extends StatelessWidget {
  const CustomizeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomizedSearchController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "customized_search".tr(),
          style: TextStyle(color: AppColors.greencolor, fontFamily: "Tejwal"),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              const Center(child: Icon(Icons.notification_add, size: 200)),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "custom_search_paragraph".tr(),
                  style: TextStyle(fontFamily: "Tejwal", fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.goToselectSearchscreen();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "lets_start".tr(),
                      style: TextStyle(
                        color: AppColors.greencolor,
                        fontFamily: "Tejwal",
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: AppColors.greencolor),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 50,
            top: 110,
            child: Obx(
              () =>
                  controller.showWidget.value
                      ? Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.1),
                            ),
                          ),
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              width: 300,
                              height: 300,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'hello'.tr(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontFamily: "Tejwal",
                                        ),
                                      ),
                                      Text(
                                        "customize_your_search_paragraph".tr(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: controller.dismissWidget,
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text('done'.tr()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            top: 360.h,
            left: 50.w,
            child: SizedBox(
              child: Image.asset("Assets/images/123.png", height: 300),
            ),
          ),
        ],
      ),
    );
  }
}
