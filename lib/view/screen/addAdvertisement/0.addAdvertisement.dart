import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/view/widget/Advertisement/ad_images_panel.dart';
import 'package:trip/view/widget/Advertisement/custompanner.dart';
import '../../widget/Advertisement/custom_drop_down_menu.dart';

class AddAdvertisement extends StatelessWidget {
  const AddAdvertisement({super.key});

  @override
  Widget build(BuildContext context) {
    AdvertisementController controller = Get.put(AdvertisementController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<AdvertisementController>(
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
            // color: AppColors.white,
              // image: DecorationImage(
                
              //   image: AssetImage("Assets/images/12.jpg"),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomBanner(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AdsImagesGrid(),
                        CustomDropDownMenu(
                          items: controller.items.typeOfAd,
                          onchanged: (String? val) {
                            controller.updateTypeOfAd(val!);
                          },
                          value: controller.typeOfAd,
                          nameofitem: "ad_of".tr(),
                          ireq: true,
                        ),
                        SizedBox(height: 14.sp),
                        controller.adDetails,
                      ],
                    ),
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
