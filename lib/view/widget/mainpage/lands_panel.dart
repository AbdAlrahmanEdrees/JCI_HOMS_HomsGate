import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/mainpagecontroller.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/widget/imagesliderassets.dart';

class LandsPanel extends StatelessWidget {
  const LandsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,8.0,0,8),
      child: Container(
        // color: AppColors.grey300.withOpacity(0.3),
        color:AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'lands_in_syria'.tr(),
                style: AppTextStyles.h13b
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ImageSliderAssets(imageUrls: controller.imageurl),
            ],
          ),
        ),
      ),
    );
  }
}
